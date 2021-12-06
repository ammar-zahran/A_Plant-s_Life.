import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PlantTrackerExpert extends StatefulWidget {
  @override
  PlantTrackerExpertState createState() => PlantTrackerExpertState();
}

class PlantTrackerExpertState extends State<PlantTrackerExpert> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3,
        title: Text('Plant Tracker', style: TextStyle(color: Colors.black)),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl:
              'https://docs.google.com/spreadsheets/d/1Vfld5I4QMh_lOuFIfjPKCjDbNFJCut_N39jMAiNamoo/edit?resourcekey#gid=518846945',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
