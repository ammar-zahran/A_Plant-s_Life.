import 'package:a_plants_life/data/nurseries_data.dart';
import 'package:a_plants_life/details/details_screen.dart';
import 'package:a_plants_life/nurseries/components/image-card.dart';
import 'package:http/http.dart' as http;
import 'package:a_plants_life/productViewPage/product_view_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class NurBodyState extends StatefulWidget {
  @override
  NurBody createState() => NurBody();
}

class NurBody extends State<NurBodyState> {
  List<Shop> shops = [];
  void getShops() async {
    var url = Uri.parse(server_url + 'create-shop/');
    var response = await http.get(url);
    var message = jsonDecode(response.body);
    List<Shop> temp_shops = [];
    if (response.statusCode == 200) {
      for (var i = 0; i < message['items'].length; i++) {
        List<Category> temp_cat_list = [];
        for (var j = 0; j < message['items'][i]['category_list'].length; j++) {
          temp_cat_list.add(Category(
              id: message['items'][i]['category_list'][j]['id'],
              title: message['items'][i]['category_list'][j]['title']));
        }
        temp_shops.add(Shop(
            id: message['items'][i]['id'],
            avatar: message['items'][i]['avatar'],
            name: message['items'][i]['name'],
            rating: message['items'][i]['rating'],
            categoryList: temp_cat_list));
      }
    } else {}
    setState(() {
      shops = temp_shops;
    });
  }

  @override
  void initState() {
    super.initState();
    getShops();
  }

  @override
  Widget build(BuildContext context) {
    // getShops();
    return ListView(
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
          SizedBox(
            height: 10,
          ),
          Column(
              children: List.generate(
            shops.length,
            (index) => InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ProductViewPage(shop: shops[index])),
                );
              },
              child: ImageCard(shop: shops[index]),
            ),
          ))
        ]);
  }
}
