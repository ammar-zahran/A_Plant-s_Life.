import 'dart:convert';

import 'package:a_plants_life/cart/Cart-page.dart';
import 'package:a_plants_life/data/Product.dart';
import 'package:a_plants_life/data/constants.dart';
import 'package:a_plants_life/data/nurseries_data.dart';
import 'package:a_plants_life/details/details_screen.dart';
import 'package:a_plants_life/nurseries/Nurseries-page.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a_plants_life/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../data/Product.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'components/getbody.dart';

class SellerPage extends StatefulWidget {
  @override
  _SellerPageState createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  List<SelfItemSeller> items = [];
  List<String> categories = [];
  @override
  void initState() {
    super.initState();
    getItems();
  }

  getItems() async {
    var url = Uri.parse(server_url + "get-orders-items/");
    List<SelfItemSeller> temp_items = [];
    List<String> tempCategories = [];
    final prefs = await SharedPreferences.getInstance();
    var username = await prefs.getString('username');
    var body = {
      'username': username,
      // 'category_id': widget.category.toString(),
    };
    var response = await http.post(url, body: body);
    Map<String, dynamic> message = jsonDecode(response.body);
    if (response.statusCode == 200 && message['status'] == 'success') {
      for (var i = 0; i < message['items'].length; i++) {
        temp_items.add(SelfItemSeller(
            id: message['items'][i]['id'] ?? '',
            date: message['items'][i]['date'] ?? '',
            shop_id: 0,
            quantity: message['items'][i]['quantity'] ?? 0,
            bill_id: int.parse(message['items'][i]['bill_id'] ?? '0'),
            title: message['items'][i]['title'] ?? '',
            shop: '',
            avatar: message['items'][i]['avatar'] ?? '',
            avatar_2: message['items'][i]['image'] ?? '',
            price: message['items'][i]['price'] ?? '',
            totalPrice: message['items'][i]['total_price'] ?? '',
            categoryTitle: message['items'][i]['category_title'] ?? '',
            username: message['items'][i]['username'] ?? ''));
        // temp_items.add(Item(
        //     id: message['items'][i]['id'] ?? '',
        //     categoryId: 0,
        //     shopId: message['items'][i]['shop_id'] ?? '',
        //     quantity: message['items'][i]['quantity'] ?? "",
        //     title: message['items'][i]['title'] ?? "",
        //     categoryTitle: message['items'][i]['category_title'],
        //     description: message['items'][i]['description'] ?? "",
        //     avatar: message['items'][i]['avatar'] ?? "",
        //     avatar_2: message['items'][i]['image'] ?? "",
        //     price: 0));

        if (!tempCategories.contains((message['items'][i]['category_title'])))
          tempCategories.add(message['items'][i]['category_title']);
      }
      setState(() {
        items = temp_items;
        categories = tempCategories;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: buildAppBar(context),
        body: TabBarView(
            children: List.generate(
                categories.length,
                (index) =>
                    GetBody(itemsList: items, category: categories[index]))),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.view_list,
          backgroundColor: Color(0xFF598C4A),
          children: [
            SpeedDialChild(
                child: Icon(Icons.add),
                label: "Add Category",
                backgroundColor: Color(0xFFD9E7CB),
                onTap: () {
                  showAddCategoryForm(context);
                }),
            SpeedDialChild(
                child: Icon(Icons.add),
                label: "Add Product",
                backgroundColor: Color(0xFFD9E7CB),
                onTap: () {
                  showAddProductForm(context);
                }),
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
          "My Nursery",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
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
              categories.length,
              (index) => Tab(
                child: Text(
                  categories[index],
                ),
              ),
            )));
  }
}

void showAddProductForm(context) async {
  void addItem(categoryId, name, price, description, image1, image2,
      origincategoryList) async {
    int catId;
    var cat = origincategoryList.where((i) => i.title == categoryId).toList();
    final prefs = await SharedPreferences.getInstance();
    var username = await prefs.getString('username') ?? "";
    var request =
        http.MultipartRequest('POST', Uri.parse(server_url + 'create-item/'));
    request.fields.addAll({
      'username': username,
      'category_id': cat[0].id.toString(),
      'title': name,
      'price': price,
      'description': description
    });
    request.files.add(await http.MultipartFile.fromPath('image1', image1.path));
    request.files.add(await http.MultipartFile.fromPath('image2', image2.path));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  List<CategoryItem> origincategoryList = [];
  var categoryId, name, price, description, dropdownValue;
  late XFile image1, image2;
  List<String> tempCategoryList = [];
  final prefs = await SharedPreferences.getInstance();
  var username = await prefs.getString('username') ?? "";
  var request =
      http.MultipartRequest('GET', Uri.parse(server_url + 'create-category/'));
  request.fields.addAll({'username': username});
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    var data = await jsonDecode(await response.stream.bytesToString());
    for (var i = 0; i < data['items'].length; i++) {
      tempCategoryList.add(data['items'][i]['title']);
      origincategoryList.add(CategoryItem(
          id: data['items'][i]['id'], title: data['items'][i]['title']));
    }
  } else {
    print(response.reasonPhrase);
  }
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text('Add Product', style: TextStyle(fontSize: 20)),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.grey,
                          size: 25,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Text('Gategory :', style: TextStyle(fontSize: 17)),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(15)),
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            iconSize: 20,
                            elevation: 16,
                            isExpanded: true,
                            style: const TextStyle(color: Colors.black),
                            onChanged: (String? newValue) {
                              dropdownValue = newValue!;
                            },
                            items: tempCategoryList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text('Name:          ', style: TextStyle(fontSize: 17)),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        child: TextField(
                          decoration: InputDecoration(),
                          onChanged: (value) {
                            name = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text('Price:           ', style: TextStyle(fontSize: 17)),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        child: TextField(
                          decoration: InputDecoration(),
                          onChanged: (value) {
                            price = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text('Description: ', style: TextStyle(fontSize: 17)),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        child: TextField(
                          decoration: InputDecoration(),
                          onChanged: (value) {
                            description = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text('image 1: ', style: TextStyle(fontSize: 17)),
                      ElevatedButton(
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          image1 = await _picker.pickImage(
                                  source: ImageSource.gallery) ??
                              XFile('');
                        },
                        child: Text('Upload Image'),
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(240, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            primary: Color(0xFFD9E7CB),
                            padding: EdgeInsets.only(left: 50, right: 50)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text('image 2: ', style: TextStyle(fontSize: 17)),
                      ElevatedButton(
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          image2 = await _picker.pickImage(
                                  source: ImageSource.gallery) ??
                              XFile('');
                        },
                        child: Text('Upload Image'),
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(240, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            primary: Color(0xFFD9E7CB),
                            padding: EdgeInsets.only(left: 50, right: 50)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        addItem(dropdownValue, name, price, description, image1,
                            image2, origincategoryList);
                        Navigator.pop(context);
                      },
                      child: Text('Add Product'),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(240, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          primary: Color(0xFF598C4A),
                          padding: EdgeInsets.only(left: 50, right: 50)),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}

class DropDownButton extends StatefulWidget {
  const DropDownButton({Key? key}) : super(key: key);

  @override
  _DropDownButtonState createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  var dropdownValue;
  var title;
  List<String> categoryList = [];
  List<CategoryItem> origincategoryList = [];
  var data = [];
  void initState() {
    super.initState();
    getCategories();
  }

  getCategories() async {
    List<String> tempCategoryList = [];
    final prefs = await SharedPreferences.getInstance();
    var username = await prefs.getString('username') ?? "";
    var request = http.MultipartRequest(
        'GET', Uri.parse(server_url + 'create-category/'));
    request.fields.addAll({'username': username});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data = await jsonDecode(await response.stream.bytesToString());
      for (var i = 0; i < data['items'].length; i++) {
        tempCategoryList.add(data['items'][i]['title']);
        origincategoryList.add(CategoryItem(
            id: data['items'][i]['id'], title: data['items'][i]['title']));
      }
    } else {
      print(response.reasonPhrase);
    }
    setState(() {
      categoryList = tempCategoryList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        padding: const EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(15)),
        child: DropdownButton<String>(
          value: dropdownValue,
          iconSize: 20,
          elevation: 16,
          isExpanded: true,
          style: const TextStyle(color: Colors.black),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: categoryList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

addCategory(var title) async {
  final prefs = await SharedPreferences.getInstance();
  var username = await prefs.getString('username') ?? "";
  var request =
      http.MultipartRequest('POST', Uri.parse(server_url + 'create-category/'));
  request.fields.addAll({'username': username, 'title': title});
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

void showAddCategoryForm(context) {
  var title;
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text('Add Category', style: TextStyle(fontSize: 20)),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.grey,
                          size: 25,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text('Name: ', style: TextStyle(fontSize: 17)),
                        Container(
                          child: TextField(
                            onChanged: (value) {
                              title = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          width: MediaQuery.of(context).size.height / 4,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        addCategory(title);
                        Navigator.pop(context);
                      },
                      child: Text('Add Catagory'),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(240, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          primary: Color(0xFF598C4A),
                          padding: EdgeInsets.only(left: 50, right: 50)),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
