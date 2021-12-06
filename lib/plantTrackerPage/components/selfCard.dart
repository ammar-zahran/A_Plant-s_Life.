import 'package:a_plants_life/data/Product.dart';
import 'package:a_plants_life/data/cart.dart';
import 'package:a_plants_life/data/nurseries_data.dart';
import 'package:a_plants_life/cart/Cart-page.dart';
import 'package:a_plants_life/theme/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SelfCard extends StatefulWidget {
  final SelfItem item;

  const SelfCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  _SelfCard createState() => _SelfCard();
}

class _SelfCard extends State<SelfCard> {
  void initState() {
    super.initState();
  }

  calculateAge(DateTime boughtDate) {
    DateTime currentDate = DateTime.now();
    int years = currentDate.year - boughtDate.year;
    int month = currentDate.month - boughtDate.month;
    int days = currentDate.day - boughtDate.day;
    String date_ = 'Age = ';
    if (years > 0) date_ += years.toString() + ' years, ';
    if (month > 0) date_ += month.toString() + ' month, ';
    if (days > 0) date_ += days.toString() + ' days, ';
    if (years == 0 && month == 0 && days == 0) date_ = 'Just bought it 😄';
    // return years.toString() +
    //     ' years, ' +
    //     month.toString() +
    //     ' months,' +
    //     days.toString() +
    //     ' days';
    return date_;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Row(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 150,
                  width: 150,
                  child: CachedNetworkImage(
                    imageUrl: server_url + "media/" + widget.item.avatar,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        "${widget.item.shop}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${widget.item.title}",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Text(
                    "price ${widget.item.price}" + " JOD/Unit",
                    style: TextStyle(
                      fontSize: 12,
                      color: warning,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "total price : ${widget.item.totalPrice}" + " JOD",
                    style: TextStyle(
                      fontSize: 12,
                      color: warning,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Qunatity = " + "${widget.item.quantity}",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                        "${calculateAge(DateTime.tryParse(widget.item.date) ?? DateTime.now())}",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                        "bill id : ${widget.item.bill_id}",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
