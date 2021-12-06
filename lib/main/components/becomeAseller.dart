import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BecomeASeller extends StatefulWidget {
  @override
  BecomeASellerState createState() => BecomeASellerState();
}

class BecomeASellerState extends State<BecomeASeller> {
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
        title: Text('Become a Seller', style: TextStyle(color: Colors.black)),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl:
              'https://docs.google.com/forms/d/e/1FAIpQLSfplcWhBOGWpLFoVUNZHF0SLQ_Kb3lgPNHO4Sv5PaXBqZAcQQ/viewform?usp=sf_link',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
