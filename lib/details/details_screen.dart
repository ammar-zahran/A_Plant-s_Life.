import 'package:a_plants_life/cart/Cart-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../data/Product.dart';
import '../data/constants.dart';
import 'components/body.dart';
import 'package:a_plants_life/details/components/body.dart';
import 'package:a_plants_life/data/nurseries_data.dart';

class DetailsScreen extends StatefulWidget {
  final Item item;

  const DetailsScreen({Key? key, required this.item}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      backgroundColor: Color(0xFFCEE4B8),
      appBar: buildAppBar(context),
      body: Body(
        item: widget.item,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFCEE4B8),
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/cart.svg"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(),
              ),
            );
          },
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
