import 'package:a_plants_life/nurseries/Nurseries-page.dart';
import 'package:a_plants_life/plantTrackerPage/components/trackerBody.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlantTracker extends StatefulWidget {
  @override
  _PlantTrackerState createState() => _PlantTrackerState();
}

class _PlantTrackerState extends State<PlantTracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: TrackerBody(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 3,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/back.svg"),
        onPressed: () {
          Navigator.pop(
            context,
            MaterialPageRoute(
              builder: (_) => Nurseriespage(),
            ),
          );
        },
      ),
      title: Text(
        "My Plants",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
