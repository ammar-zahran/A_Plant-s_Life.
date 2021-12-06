import 'package:a_plants_life/data/Product.dart';
import 'package:a_plants_life/data/nurseries_data.dart';
import 'package:a_plants_life/details/details_screen.dart';
import 'package:a_plants_life/plantTrackerPage/components/selfCard.dart';
import 'package:a_plants_life/plantTrackerPage/trackingPage.dart';
import 'package:a_plants_life/productViewPage/components/product_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class TrackerBody extends StatefulWidget {
  @override
  _TrackerBody createState() => _TrackerBody();
}

class _TrackerBody extends State<TrackerBody> {
  List<SelfItem> selfContent = [];
  late XFile _image;
  final picker = ImagePicker();
  void initState() {
    super.initState();
    getCartContent();
  }

  getCartContent() async {
    final prefs = await SharedPreferences.getInstance();
    var username = await prefs.getString('username') ?? '';
    var request =
        http.MultipartRequest('GET', Uri.parse(server_url + 'orders/'));
    request.fields.addAll({
      'username': username,
    });

    http.StreamedResponse response = await request.send();
    var data = jsonDecode((await response.stream.bytesToString()));
    List<SelfItem> temp_cartContent = [];
    for (var i = 0; i < data['items'].length; i++) {
      //  DateTime now =DateTime.tryParse(data['items'][i]['date']) ?? DateTime.now();
      //  final DateFormat formatter = DateFormat('yyyy-MM-dd');
      //  final String formatted = formatter.format(now);
      temp_cartContent.add(SelfItem(
          id: data['items'][i]['id'],
          date: data['items'][i]['date'] ?? DateTime.now().toString(),
          shop_id: data['items'][i]['shop_id'],
          quantity: data['items'][i]['quantity'],
          bill_id: int.parse(data['items'][i]['bill_id']),
          title: data['items'][i]['title'],
          shop: data['items'][i]['shop'],
          avatar: data['items'][i]['avatar'],
          avatar_2: data['items'][i]['avatar_2'],
          price: data['items'][i]['price'],
          totalPrice: data['items'][i]['total_price']));
    }

    setState(() {
      selfContent = temp_cartContent;
    });
  }

  uploadImage(order_id) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile image =
        await _picker.pickImage(source: ImageSource.gallery) ?? XFile('');
    var request =
        http.MultipartRequest('POST', Uri.parse(server_url + 'upload-image/'));
    request.fields.addAll({'order_id': order_id.toString()});
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
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
          Column(
            children: List.generate(
              selfContent.length,
              (index) => InkWell(
                onTap: () {
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
                              Text('Upload Your Plant Images Here'),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  uploadImage(selfContent[index].id);
                                },
                                child: Text('Upload Image'),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    primary: Color(0xFF598C4A),
                                    padding:
                                        EdgeInsets.only(left: 50, right: 50)),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              ElevatedButton(
                                child: const Text('Submit'),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF598C4A),
                                ),
                                onPressed: () => Navigator.pop(context),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: SelfCard(
                  item: selfContent[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
