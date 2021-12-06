import 'package:a_plants_life/cart/Cart-page.dart';
import 'package:a_plants_life/data/constants.dart';
import 'package:a_plants_life/login_and_signUp/Login/login_screen.dart';
import 'package:a_plants_life/main/components/Feedbackpage.dart';
import 'package:a_plants_life/main/components/becomeAnExpert.dart';
import 'package:a_plants_life/main/components/becomeAseller.dart';
import 'package:a_plants_life/main/components/profile.dart';
import 'package:a_plants_life/main/components/settings.dart';
import 'package:flutter_svg/svg.dart';
import 'package:a_plants_life/main/components/CarouselWithDotsPage.dart';
import 'package:flutter/material.dart';
import 'package:a_plants_life/main.dart';
import 'components/categories.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:a_plants_life/data/nurseries_data.dart';

class UserInfo extends StatefulWidget {
  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<UserInfo> {
  String username = "";
  List<String> SliderImagesList = [];
  void getInfo() async {
    final prefs = await SharedPreferences.getInstance();
    username = (prefs.getString('username') ?? "");
    setState(() {
      username = username;
    });
  }

  getSlides() async {
    var request =
        http.MultipartRequest('GET', Uri.parse(server_url + 'slider/'));
    http.StreamedResponse response = await request.send();
    var data = jsonDecode((await response.stream.bytesToString()));
    List<String> images = [];
    for (var i = 0; i < data['items'].length; i++) {
      images.add(data['items'][i]['image']);
    }
    setState(() {
      SliderImagesList = images;
    });
  }

  void initState() {
    super.initState();
    getInfo();
    getSlides();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3,
        title: Text("A Plant's Life", style: TextStyle(color: Colors.black)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
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
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/gorgc.jpg'),
                    radius: 60,
                  ),
                  Text(username)
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserInfo(),
                  ),
                );
              },
              child: ListTile(
                title: Text('Home'),
                leading: Icon(
                  Icons.home,
                  color: Color(0xFF598C4A),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileSettings(),
                  ),
                );
              },
              child: ListTile(
                title: Text('Profile'),
                leading: Icon(
                  Icons.person,
                  color: Color(0xFF598C4A),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppSettings(),
                  ),
                );
              },
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(
                  Icons.settings,
                  color: Color(0xFF598C4A),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BecomeASeller(),
                  ),
                );
              },
              child: ListTile(
                title: Text('Become a Seller'),
                leading: Icon(
                  Icons.sell,
                  color: Color(0xFF598C4A),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BecomeAnExpert(),
                  ),
                );
              },
              child: ListTile(
                title: Text('Become an Expert'),
                leading: Icon(
                  Icons.admin_panel_settings,
                  color: Color(0xFF598C4A),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedbackPage(),
                  ),
                );
              },
              child: ListTile(
                title: Text('Feedback'),
                leading: Icon(
                  Icons.feedback,
                  color: Color(0xFF598C4A),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: ListTile(
                title: Text('Logout'),
                leading: Icon(
                  Icons.logout,
                  color: Color(0xFF598C4A),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            CarouselWithDotsPage(imgList: SliderImagesList),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xFFD9E7CB),
                ),
                padding: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Grow Big. Spend little',
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Enjoy Our Summer Sale!",
                            style: TextStyle(fontSize: 12)),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('Nurseries');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF598C4A),
                          ),
                          child: Text('Find a Store'),
                        ),
                      ],
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width / 17),
                    Image.asset(
                      'assets/images/cartad9.png',
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width / 2.65,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            CategoriesScroller()
          ],
        ),
      ),
    );
  }
}
/* ElevatedButton(
                  onPressed: () {},
                  child: Text('Profile'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    primary: Colors.green,
                    padding: EdgeInsets.only(
                        left: 50, right: 50, top: 50, bottom: 50),
                  ),
                ),*/



                   /* Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipOval(
                  child: Container(
                    child: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: Image.asset(

                        'assets/images/nurseries-.png',

                        'assets/images/123.png',

                      ),
                      iconSize: 125,
                      onPressed: () { },
                    ),
                  ),
                ),
                ClipOval(
                  child: Container(
                    child: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: Image.asset(
                        'assets/images/nurseries-.png',
                      ),
                      iconSize: 125,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Nurseriespage(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipOval(
                  child: Container(
                    child: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: Image.asset(
                        'assets/images/nurseries-.png',
                      ),
                      iconSize: 125,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductViewPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                ClipOval(
                  child: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Image.asset('assets/images/nurseries-.png'),
                    iconSize: 125,
                    onPressed: () {},
                  ),
                ),
              ],
            ),*/