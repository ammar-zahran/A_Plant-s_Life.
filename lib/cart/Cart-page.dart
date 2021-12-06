import 'dart:convert';
import 'package:a_plants_life/cart/components/cartCard.dart';
import 'package:a_plants_life/cart/components/productCard.dart';
import 'package:a_plants_life/data/Product.dart';
import 'package:a_plants_life/data/cart.dart';
import 'package:a_plants_life/data/nurseries_data.dart';
import 'package:a_plants_life/login_and_signUp/Signup/components/body.dart';
import 'package:a_plants_life/main/Home-page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a_plants_life/nurseries/Nurseries-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> cartContent = [];
  double totalPrice = 0;
  var username;
  void initState() {
    super.initState();
    getCartContent();
  }

  getCartContent() async {
    final prefs = await SharedPreferences.getInstance();
    var hasContent = prefs.getBool('CartHasContent') ?? false;
    if (hasContent) {
      var content = await prefs.getString('CartContent') ?? "[]";
      var data = jsonDecode(content);
      List<CartItem> temp_cartContent = [];
      for (var i = 0; i < data.length; i++) {
        temp_cartContent.add(CartItem(
            shopId: data[i]['shopId'],
            image: data[i]['image'],
            name: data[i]['name'],
            id: data[i]['id'],
            price: data[i]['price'],
            totalPrice: data[i]['totalPrice'],
            quantity: data[i]['quantity']));
        totalPrice += data[i]['totalPrice'];
      }
      var t_username = await prefs.getString('username');

      setState(() {
        cartContent = temp_cartContent;
        username = t_username;
      });
    }
  }

  buyItems() async {
    var MessageTitle = "";
    var MessageBody = "";
    AlertDialog alert;
    final prefs = await SharedPreferences.getInstance();
    List tempObjects = [];
    for (int i = 0; i < cartContent.length; i++) {
      tempObjects.add({cartContent[i].id: cartContent[i].quantity});
    }
    var url = Uri.parse(server_url + "orders/");
    var body = {
      'username': username,
      'shop_id': cartContent[0].shopId.toString(),
      'items_ids': tempObjects.toString(),
    };
    var response = await http.post(url, body: body);
    Map<String, dynamic> message = jsonDecode(response.body);
    prefs.remove('CartContent');

    if (response.statusCode == 200 && message['status'] == 'success') {
      MessageTitle = "Success !";
      MessageBody = message['message'];
      alert = AlertDialog(
        title: Text(MessageTitle),
        content: Text(MessageBody),
        actions: [
          TextButton(
            child: Text("Continue"),
            onPressed: () async {
              if (message['status'] == 'success') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Nurseriespage();
                    },
                  ),
                );
              } else {
                MessageTitle = "Ops!! something went wrong !";
                MessageBody = message['message'];
                alert = AlertDialog(
                  title: Text(MessageTitle),
                  content: Text(MessageBody),
                );
              }
            },
          )
        ],
      );
    } else {
      MessageTitle = "Ops!! something went wrong !";
      MessageBody = message['message'];
      alert = AlertDialog(
        title: Text(MessageTitle),
        content: Text(MessageBody),
      );
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Expanded(
                child: ListView.builder(
                  itemCount: cartContent.length,
                  itemBuilder: (context, index) {
                    return CartCard(
                      item: cartContent[index],
                    );
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Confiramtion"),
                      content: Text(
                          "Total price is :( ${totalPrice} JOD ), do  you want to continue ?"),
                      actions: [
                        TextButton(
                          child: Text("Buy"),
                          onPressed: () async {
                            buyItems();
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: Text("cancel"),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  },
                );
              },
              child: Text('Checkout !'),
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(240, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  primary: Color(0xFF598C4A),
                  padding: EdgeInsets.only(left: 50, right: 50)),
            )
          ],
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
        "My Cart",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
