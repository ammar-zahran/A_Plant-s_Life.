import 'package:a_plants_life/data/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'cart_counter.dart';
import '../../data/constants.dart';
import '../../data/Product.dart';
import 'globals.dart';
import 'package:a_plants_life/data/nurseries_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class AddToCart extends StatelessWidget {
  const AddToCart({
    Key? key,
    required this.item,
  }) : super(key: key);
  final Item item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: kDefaultPaddin),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.amberAccent,
              ),
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/add_to_cart.svg",
                color: Colors.amberAccent,
              ),
              onPressed: () async {
                bool flag = false;
                final prefs = await SharedPreferences.getInstance();
                var content = await prefs.getString('CartContent') ?? "[]";
                var data = CartItem.decode(content);
                List<CartItem> temp_cartContent = [];

                for (var i = 0; i < data.length; i++) {
                  temp_cartContent.add(CartItem(
                                              shopId: item.shopId,

                      image: data[i].image,
                      name: data[i].name,
                      id: data[i].id,
                      price: data[i].price,
                      quantity: data[i].quantity,
                      totalPrice: data[i].price * data[i].quantity));
                }
                int index = -1;
                temp_cartContent.forEach((element) {
                  if (element.id == item.id)
                    index = temp_cartContent.indexOf(element);
                });

                if (index != -1) {
                  int quantity = temp_cartContent[index].quantity;
                  quantity += numOfItems;
                  temp_cartContent[index].quantity = quantity;
                  temp_cartContent[index].totalPrice =
                      quantity * temp_cartContent[index].price;
                } else {
                  temp_cartContent.add(CartItem(
                                              shopId: item.shopId,

                      image: item.avatar,
                      name: item.title,
                      id: item.id,
                      price: item.price,
                      quantity: numOfItems,
                      totalPrice: numOfItems * item.price));
                }
                var hasContent = prefs.setBool('CartHasContent', true);
                String temp_list = CartItem.encode(temp_cartContent);
                prefs.setString('CartContent', temp_list);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "The ${item.title} has been added to your cart, total : ${numOfItems * item.price}")));
                numOfItems = 1;
              },
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Buy  Now".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
