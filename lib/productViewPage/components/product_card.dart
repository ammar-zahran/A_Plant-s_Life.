import 'package:a_plants_life/data/Product.dart';
import 'package:a_plants_life/data/nurseries_data.dart';
import 'package:a_plants_life/theme/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Item item;

  const ProductCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Row(
            children: <Widget>[
              Container(
                height: 150,
                width: 150,
                child: CachedNetworkImage(
                  imageUrl: server_url + "media/" + item.avatar,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${item.title}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "${item.price}" + " JOD",
                        style: TextStyle(
                          fontSize: 17,
                          color: warning,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
