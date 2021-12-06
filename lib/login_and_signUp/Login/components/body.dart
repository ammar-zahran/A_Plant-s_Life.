import 'package:a_plants_life/login_and_signUp/Login/components/background.dart';
import 'package:a_plants_life/login_and_signUp/Signup/signup_screen.dart';
import 'package:a_plants_life/login_and_signUp/components/already_have_an_account_acheck.dart';
import 'package:a_plants_life/login_and_signUp/components/rounded_button.dart';
import 'package:a_plants_life/login_and_signUp/components/rounded_input_field.dart';
import 'package:a_plants_life/login_and_signUp/components/rounded_password_field.dart';
import 'package:a_plants_life/main/Home-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a_plants_life/data/nurseries_data.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var MessageTitle = "";
    var MessageBody = "";
    AlertDialog alert;
    var username = "";
    var password = "";
    Login() async {
      var url = Uri.parse(server_url + "login/");
      var body = {
        'username': username,
        'password': password,
      };

      var response = await http.post(url, body: body);
      Map<String, dynamic> message = jsonDecode(response.body);
      if (response.statusCode == 200 && message['status'] == 'success') {
        MessageTitle = "Success !";
        MessageBody = message['message'];
        alert = AlertDialog(
          title: Text(MessageTitle),
          content: Text(MessageBody),
          actions: [
            TextButton(
              child: Text("Continue"),
              onPressed: () async {
                if (message['status'] == 'success') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UserInfo();
                      },
                    ),
                  );
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('IsLoggedIn', true);
                  await prefs.setString('token', message['token']);
                  await prefs.setString('username', message['username']);
                  await prefs.setString(
                      'status', message['user_obj']['status']);
                } else {
                  MessageTitle = "Failure !";
                  MessageBody = message['message'];
                  alert = AlertDialog(
                    title: Text(MessageTitle),
                    content: Text(MessageBody),
                  );
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/julia's-logo2.png",
              height: size.height * 0.45,
            ),
            RoundedInputField(
              icon: Icons.person,
              hintText: "Your Email",
              onChanged: (value) {
                username = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Login();
              },
              child: RoundedButton(
                text: "LOGIN",
              ),
            ),
            SizedBox(height: size.height * 0.01),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
              child: AlreadyHaveAnAccountCheck(
                text: 'Don’t have an Account ? ',
                text1: 'Sign Up',
              ),
            )
          ],
        ),
      ),
    );
  }
}
