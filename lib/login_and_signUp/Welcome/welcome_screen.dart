import 'package:a_plants_life/login_and_signUp/Welcome/components/body.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:a_plants_life/login_and_signUp/components/rounded_button.dart';
import 'package:a_plants_life/login_and_signUp/Welcome/components/background.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Body(),
  //   );
  // }
}

class SplashScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Scaffold(
                      body: Body(),
                    ))));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/julia's-logo2.png",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.001),
          ],
        ),
      ),
    );
  }
}
