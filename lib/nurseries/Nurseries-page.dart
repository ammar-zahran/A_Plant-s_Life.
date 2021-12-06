import 'package:a_plants_life/data/constants.dart';
import 'package:a_plants_life/nurseries/components/nurseries_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import '../cart/Cart-page.dart';
import '../main/Home-page.dart';

class Nurseriespage extends StatefulWidget {
  @override
  _NurseriespageState createState() => _NurseriespageState();
}

class _NurseriespageState extends State<Nurseriespage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3,
        title: Text("Nurseries", style: TextStyle(color: Colors.black)),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: SvgPicture.asset("assets/icons/back.svg"),
            iconSize: 25,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserInfo(),
                ),
              );
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/cart.svg",
                // By default our  icon color is white
                color: kTextColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: NurBodyState(),
    );
  }
}
