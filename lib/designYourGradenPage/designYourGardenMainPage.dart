import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DesignYourGardenPage extends StatefulWidget {
  @override
  DesignYourGardenPageState createState() => DesignYourGardenPageState();
}

class DesignYourGardenPageState extends State<DesignYourGardenPage> {
  @override
  void initState() {
    super.initState();

    // Enable hybrid composition.
    WidgetsFlutterBinding.ensureInitialized();
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
              'https://docs.google.com/forms/d/e/1FAIpQLSfgUvRxUK55_h3xK0CmrkTZh0lOX3CZqLoj8LLoh8SmB_ABZw/viewform?usp=sf_link',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
