import 'package:a_plants_life/cart/Cart-page.dart';
import 'package:a_plants_life/data/constants.dart';
import 'package:a_plants_life/main/Home-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DesignYourGardenPage extends StatefulWidget {
  const DesignYourGardenPage({Key? key}) : super(key: key);

  @override
  _DesignYourGardenPageState createState() => _DesignYourGardenPageState();
}

class _DesignYourGardenPageState extends State<DesignYourGardenPage> {
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
    );
  }
}
