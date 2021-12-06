import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Welcome_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SlidingUpPanel(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          minHeight: 50,
          panel: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Text(
                  "Terms of Service",
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 100),
                child: Text(
                  "Terms of Service",
                ),
              ),
            ],
          ),
          body: Center(
            child: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/wp5291341-green-leaf-aesthetic-wallpapers.jpg"),
                    fit: BoxFit.fill),
              ),
              child: Column(
                children: [
                  SizedBox(height: 250),
                  Text(
                    "A Plant's Life",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 150),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        primary: Colors.grey,
                        padding: EdgeInsets.only(left: 50, right: 50)),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Sign up',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        primary: Colors.grey,
                        padding: EdgeInsets.only(left: 45, right: 45)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
