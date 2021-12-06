import 'package:a_plants_life/data/cart.dart';
import 'package:a_plants_life/designYourGradenPage/designYourGardenMainPage.dart';
import 'package:a_plants_life/expertPage/components/designyourgradenexprt.dart';
import 'package:a_plants_life/expertPage/components/palnttrackerexpert.dart';
import 'package:a_plants_life/expertPage/expertMainPage.dart';
import 'package:a_plants_life/main/Home-page.dart';
import 'package:a_plants_life/plantTrackerPage/plantTrackerMainPage.dart';
import 'package:a_plants_life/sellerPage/seller_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_and_signUp/Welcome/welcome_screen.dart';
import 'nurseries/Nurseries-page.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Cart(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
      routes: {
        'My Nursery': (context) {
          return SellerPage();
        },
        'Nurseries': (conext) {
          return Nurseriespage();
        },
        'Plant Tracker': (conext) {
          return PlantTracker();
        },
        'Design Your Garden': (conext) {
          return DesignYourGardenPage();
        },
        'Expert': (conext) {
          return ExpertPage();
        },
        'ExpertDesgin': (conext) {
          return DesginYourGardenExpert();
        },
        'ExpertTracker': (conext) {
          return PlantTrackerExpert();
        }
      },
      // initialRoute: PageSplash.id,
    );
  }
}

final List<String> imgList = [
  'assets/images/tips1.jpeg',
  'assets/images/offers.jpg',
  'assets/images/weather.jpg'
];
