import 'package:a_plants_life/login_and_signUp/Login/login_screen.dart';
import 'package:a_plants_life/login_and_signUp/Signup/components/background.dart';
import 'package:a_plants_life/login_and_signUp/components/already_have_an_account_acheck.dart';
import 'package:a_plants_life/login_and_signUp/components/rounded_button.dart';
import 'package:a_plants_life/login_and_signUp/components/rounded_input_field.dart';
import 'package:a_plants_life/login_and_signUp/components/rounded_password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a_plants_life/data/nurseries_data.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var UserName;
    var Email;
    var Phone;
    var Password;
    var MessageTitle = "";
    var MessageBody = "";
    AlertDialog alert;
    registerUser() async {
      var url = Uri.parse(server_url + 'register_user/');
      var body = {
        'username': UserName,
        // 'first_name': 'laith',
        // 'last_name': 'obaiyat',
        // 'date_of_birth': '1998-08-31',
        'password': Password,
        'status': 'Customer',
        'phone': Phone,
        'email': Email
      };

      var response = await http.post(url, body: body);
      Map<String, dynamic> message = jsonDecode(response.body);
      if (response.statusCode == 200) {
        MessageTitle = "Success !";
        MessageBody = message['message'];

        alert = AlertDialog(
          title: Text(MessageTitle),
          content: Text(MessageBody),
          actions: [
            TextButton(
              child: Text("Continue"),
              onPressed: () async {
                if (message['message'] == 'User created') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('IsLoggedIn', true);
                  prefs.setString('token', message['token']);
                }
              },
            )
          ],
        );
      } else {
        MessageTitle = "Failure !";
        MessageBody = message['message'];
        alert = AlertDialog(
          title: Text(MessageTitle),
          content: Text(MessageBody),
        );
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Background(
      key: key,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/julia's-logo2.png",
              height: size.height * 0.3,
            ),
            RoundedInputField(
              icon: Icons.person,
              hintText: "Name",
              onChanged: (value) {
                UserName = value;
              },
            ),
            RoundedInputField(
              icon: Icons.email,
              hintText: "Email",
              onChanged: (value) {
                Email = value;
              },
            ),
            RoundedInputField(
              icon: Icons.phone,
              hintText: "Phone Number",
              onChanged: (value) {
                Phone = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                Password = value;
              },
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                registerUser();
              },
              child: RoundedButton(
                text: "SIGNUP",
              ),
            ),
            SizedBox(height: size.height * 0.03),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
              child: AlreadyHaveAnAccountCheck(
                text: 'Already have an Account ? ',
                text1: 'Sign In',
              ),
            )
          ],
        ),
      ),
    );
  }
}
