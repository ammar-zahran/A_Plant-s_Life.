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

class CartCard extends StatefulWidget {
  final CartItem item;

  const CartCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  _CartCard createState() => _CartCard();
}

class _CartCard extends State<CartCard> {
  void initState() {
    super.initState();
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
                    imageUrl: server_url + "media/" + widget.item.image,
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
                        "${widget.item.name}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          var content =
                              await prefs.getString('CartContent') ?? "";
                          var data = jsonDecode(content);
                          List<CartItem> temp_cartContent = [];
                          for (var i = 0; i < data.length; i++) {
                            temp_cartContent.add(CartItem(
                              shopId:data[i]['shopId'],
                                image: data[i]['image'],
                                name: data[i]['name'],
                                id: data[i]['id'],
                                price: data[i]['price'],
                                totalPrice: data[i]['totalPrice'],
                                quantity: data[i]['quantity']));
                          }
                          int index = -1;
                          temp_cartContent.forEach((element) {
                            if (element.id == widget.item.id)
                              index = temp_cartContent.indexOf(element);
                          });

                          if (index != -1) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "The ${temp_cartContent[index].name} has been removed from your cart successfully !")));

                            temp_cartContent.removeAt(index);
                          }
                          String temp_list = CartItem.encode(temp_cartContent);
                          prefs.remove('CartContent');
                          prefs.setString('CartContent', temp_list);
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CartPage(),
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Text(
                    "price ${widget.item.price}" + " JOD",
                    style: TextStyle(
                      fontSize: 17,
                      color: warning,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "total price : ${widget.item.totalPrice}" + " JOD",
                    style: TextStyle(
                      fontSize: 17,
                      color: warning,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Qunatity = " + "${widget.item.quantity}",
                    style: TextStyle(fontSize: 17),
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
