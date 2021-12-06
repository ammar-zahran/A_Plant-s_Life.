import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DesginYourGardenExpert extends StatefulWidget {
  @override
  DesginYourGardenExpertState createState() => DesginYourGardenExpertState();
}

class DesginYourGardenExpertState extends State<DesginYourGardenExpert> {
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
        title:
            Text('Design Your Garden', style: TextStyle(color: Colors.black)),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl:
              'https://docs.google.com/spreadsheets/d/1k3CjhcNdY451uj-nsyZfQoe2TB_hWxPxx3QciAmG-M8/edit?resourcekey#gid=1510369836',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
