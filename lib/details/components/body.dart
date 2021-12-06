import 'package:a_plants_life/data/nurseries_data.dart';
import 'package:a_plants_life/details/components/cart_counter.dart';
import 'package:flutter/material.dart';

import '../../data/Product.dart';
import '../../data/constants.dart';
import 'add_to_cart.dart';
import 'color_and_size.dart';

import 'description.dart';
import 'product_title_with_image.dart';

class Body extends StatelessWidget {
  final Item item;

  const Body({Key? key, required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.3),
                    padding: EdgeInsets.only(
                      top: size.height * 0.12,
                      left: kDefaultPaddin,
                      right: kDefaultPaddin,
                    ),
                    // height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        // ColorAndSize(
                        //   item: item,
                        // ),
                        SizedBox(height: kDefaultPaddin / 2),
                        Description(
                          item: item,
                        ),
                        SizedBox(height: kDefaultPaddin / 2),
                        CartCounter(),
                        SizedBox(height: kDefaultPaddin / 2),
                        AddToCart(
                          item: item,
                        )
                      ],
                    ),
                  ),
                  ProductTitleWithImage(
                    item: item,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
