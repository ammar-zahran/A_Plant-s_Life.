import 'package:a_plants_life/data/Product.dart';
import 'package:a_plants_life/data/nurseries_data.dart';
import 'package:a_plants_life/details/details_screen.dart';
import 'package:a_plants_life/productViewPage/components/product_card.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GetBody extends StatefulWidget {
  final int shopId;
  final int category;

  const GetBody({
    Key? key,
    required this.shopId,
    required this.category,
  }) : super(key: key);

  @override
  _GetBody createState() => _GetBody();
}

class _GetBody extends State<GetBody> {
  List<Item> items = [];
  @override
  void initState() {
    super.initState();
    getItems();
  }

  getItems() async {
    var url = Uri.parse(server_url + "get-shop-items/");
    List<Item> temp_items = [];
    var body = {
      'shop_id': widget.shopId.toString(),
      'category_id': widget.category.toString(),
    };
    var response = await http.post(url, body: body);
    Map<String, dynamic> message = jsonDecode(response.body);
    if (response.statusCode == 200 && message['status'] == 'success') {
      for (var i = 0; i < message['items'].length; i++) {
        temp_items.add(Item(
            id: message['items'][i]['id'] ?? '',
            categoryId: message['items'][i]['category_id'] ?? "",
            shopId: message['items'][i]['shop_id'] ?? '',
            quantity: message['items'][i]['quantity'] ?? "",
            title: message['items'][i]['title'] ?? "",
            categoryTitle: message['items'][i]['category_title'],
            description: message['items'][i]['description'] ?? "",
            avatar: message['items'][i]['avatar'] ?? "",
            avatar_2: message['items'][i]['avatar_2'] ?? "",
            price: message['items'][i]['price'] ?? ""));
      }
      setState(() {
        items = temp_items;
      });
    }
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailsScreen(
                        item: items[index],
                      ),
                    ),
                  );
                },
                child: ProductCard(
                  item: items[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
