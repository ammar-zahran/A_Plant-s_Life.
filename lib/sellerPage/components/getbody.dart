import 'package:a_plants_life/data/Product.dart';
import 'package:a_plants_life/data/nurseries_data.dart';
import 'package:a_plants_life/details/details_screen.dart';
import 'package:a_plants_life/plantTrackerPage/components/selfCard.dart';
import 'package:a_plants_life/plantTrackerPage/components/selfCardSeller.dart';
import 'package:a_plants_life/productViewPage/components/product_card.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GetBody extends StatefulWidget {
  final List<SelfItemSeller> itemsList;
  final String category;
  const GetBody({
    Key? key,
    required this.itemsList,
    required this.category,
  }) : super(key: key);
  @override
  _GetBody createState() => _GetBody();
}

class _GetBody extends State<GetBody> {
  List<SelfItemSeller> items = [];
  @override
  void initState() {
    super.initState();
    filterOnCategory();
  }

  filterOnCategory() {
    List<SelfItemSeller> temp_items = [];
    for (var i = 0; i < widget.itemsList.length; i++) {
      if (widget.itemsList[i].categoryTitle == widget.category) {
        temp_items.add(widget.itemsList[i]);
      }
    }
    setState(() {
      items = temp_items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.only(left: 20, right: 20),
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Center(
            child: Container(
              width: 300,
              child: CupertinoSearchTextField(),
            ),
          ),
          Column(
            children: List.generate(
              items.length,
              (index) => InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => DetailsScreen(
                  //       item: items[index],
                  //     ),
                  //   ),
                  // );
                },
                child: Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  child: SelfCardSeller(
                    item: items[index],
                  ),
                  actions: <Widget>[],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
