import 'package:a_plants_life/expertPage/components/expBody.dart';
import 'package:a_plants_life/main/Home-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExpertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3,
        title: Text("Expert", style: TextStyle(color: Colors.black)),
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
      ),
      body: ExpBody(),
    );
  }
}
