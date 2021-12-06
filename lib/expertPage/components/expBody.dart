import 'package:a_plants_life/data/nurseries_data.dart';
import 'package:a_plants_life/details/details_screen.dart';
import 'package:a_plants_life/expertPage/components/expCard.dart';

import 'package:a_plants_life/main/Home-page.dart';
import 'package:a_plants_life/nurseries/components/image-card.dart';

import 'package:a_plants_life/productViewPage/product_view_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:a_plants_life/data/nurseries_data.dart';

class ExpBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 25,
        ),
        ExpCard(
          page: 'ExpertTracker',
          title: 'Plant Tracker',
          image: 'assets/images/plant tr.jpg',
        ),
        SizedBox(
          height: 15,
        ),
        ExpCard(
          title: 'Design Your Garden',
          image: 'assets/images/garden-landscape.jpg',
          page: 'ExpertDesgin',
        ),
      ],
    );
  }
}
