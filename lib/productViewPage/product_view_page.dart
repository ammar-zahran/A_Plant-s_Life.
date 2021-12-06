import 'package:a_plants_life/cart/Cart-page.dart';
import 'package:a_plants_life/data/Product.dart';
import 'package:a_plants_life/data/constants.dart';
import 'package:a_plants_life/data/nurseries_data.dart';
import 'package:a_plants_life/details/details_screen.dart';
import 'package:a_plants_life/nurseries/Nurseries-page.dart';

import 'package:a_plants_life/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import '../../data/Product.dart';
import 'package:line_icons/line_icons.dart';

import 'components/getbody.dart';

class ProductViewPage extends StatefulWidget {
  final Shop shop;

  const ProductViewPage({
    Key? key,
    required this.shop,
  }) : super(key: key);

  @override
  _ProductViewPageState createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  double rating = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.shop.categoryList.length,
      child: Scaffold(
        appBar: buildAppBar(context),
        body: TabBarView(
            children: List.generate(
                widget.shop.categoryList.length,
                (index) => GetBody(
                    shopId: widget.shop.id,
                    category: widget.shop.categoryList[index].id))
            // children: [GetBody(shopId: widget.shop.id,category:1), GetBody(shopId: widget.shop.id,category:2),
            //  GetBody(shopId: widget.shop.id,category:3), GetBody(shopId: widget.shop.id,category:4)],
            ),
      ),
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
        "${widget.shop.name}",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.star_border,
            color: kTextColor,
          ),
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text('Rate This Shop'),
                        SizedBox(
                          height: 10,
                        ),
                        RatingBar.builder(
                            initialRating: 3,
                            updateOnDrag: true,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                this.rating = rating;
                              });
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          child: const Text('Submit'),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        IconButton(
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
      ],
      bottom: TabBar(
          labelColor: Color(0xFFC88D67),
          isScrollable: true,
          tabs: List.generate(
            widget.shop.categoryList.length,
            (index) => Tab(
              child: Text(
                widget.shop.categoryList[index].title,
              ),
            ),
          )),
    );
  }
}
