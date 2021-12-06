import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FeedbackPage extends StatefulWidget {
  @override
  FeedbackPageState createState() => FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> {
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
        title: Text('Feedback', style: TextStyle(color: Colors.black)),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl:
              'https://docs.google.com/forms/d/e/1FAIpQLSeq9extGe3jqtjTc1hDSGST7tKtv6oeuSCVrVI3YOc_2QHjlQ/viewform?usp=sf_link',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
