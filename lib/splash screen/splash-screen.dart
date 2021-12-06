import 'dart:async';
import 'package:a_plants_life/main/Home-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageSplash extends StatefulWidget {
  static const String id = 'PageSplash';

  @override
  _PageSplashState createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
       var route = MaterialPageRoute(builder: (context) => UserInfo());
       Navigator.push(context, route);
      // Navigator.pushNamed(context, );
     // Navigator.pushReplacementNamed(context, HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                'assets/images/logo.png',
                width: 150.w,
                height: 150.w,
              ),
            ),
            SizedBox(height: 10),
            Text("A Plant's Life"),
          ],
        ),
      )),
    );
  }
}
