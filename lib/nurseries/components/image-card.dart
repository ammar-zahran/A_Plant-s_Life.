import 'package:a_plants_life/data/nurseries_data.dart';

import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final Shop shop;

  const ImageCard({
    Key? key,
    required this.shop,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.symmetric(horizontal: 15),
          elevation: 10,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    server_url+"media/"+shop.avatar,
                    height: MediaQuery.of(context).size.height / 4.5,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 20),
                    Text(
                      shop.name,
                      style: TextStyle(fontSize: 20),
                    ),
                  ]),
              ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Rating: ${shop.rating}",
                    style: TextStyle(fontSize: 15, color: Colors.green),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
