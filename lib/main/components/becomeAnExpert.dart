import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BecomeAnExpert extends StatefulWidget {
  @override
  BecomeAnExpertState createState() => BecomeAnExpertState();
}

class BecomeAnExpertState extends State<BecomeAnExpert> {
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
        title: Text('Become an Expert', style: TextStyle(color: Colors.black)),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl:
              'https://docs.google.com/forms/d/e/1FAIpQLScISGIcT4k_hOXoJo8SGx5As-DKiaSb6plXWgguPDSeWcLewg/viewform?usp=sf_link',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
