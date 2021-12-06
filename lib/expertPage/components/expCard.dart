import 'package:a_plants_life/main/Home-page.dart';
import 'package:flutter/material.dart';

class ExpCard extends StatelessWidget {
  final String title;
  final String image;
  final String page;

  const ExpCard({
    Key? key,
    required this.page,
    required this.title,
    required this.image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(page);
          },
          child: Card(
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
                    Image.asset(
                      '$image',
                      height: MediaQuery.of(context).size.height / 3,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 20),
                      Text(
                        '$title',
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
