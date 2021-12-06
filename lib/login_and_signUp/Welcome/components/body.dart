import 'package:a_plants_life/login_and_signUp/Login/login_screen.dart';
import 'package:a_plants_life/login_and_signUp/Signup/signup_screen.dart';
import 'package:a_plants_life/login_and_signUp/Welcome/components/background.dart';
import 'package:a_plants_life/login_and_signUp/components/rounded_button.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/julia's-logo2.png",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.001),
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
              child: RoundedButton(
                color: Color(0xFF224500),
                text: "LOGIN",
              ),
            ),
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
              child: RoundedButton(
                text: "SIGN UP",
                color: Color(0xFF336633),
                textColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
