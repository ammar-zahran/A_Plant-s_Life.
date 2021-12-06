import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:a_plants_life/data/nurseries_data.dart';
import '../../data/constants.dart';
import '../../data/Product.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            item.categoryTitle,
            style: TextStyle(color: Colors.white),
          ),
          Text(
            item.title,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: kDefaultPaddin),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Price\n"),
                    TextSpan(
                      text: "${item.price}\JD",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: CachedNetworkImage(
                imageUrl: server_url + "media/" + item.avatar_2,
                height: MediaQuery.of(context).size.height / 4,
                fit: BoxFit.contain,
              ))
            ],
          )
        ],
      ),
    );
  }
}

  //  Expanded(
  //               child: Image.network(
  //                 server_url+"media/"+ item.avatar,
  //                 height: MediaQuery.of(context).size.height / 3,
  //                 fit: BoxFit.fill,
  //               ),