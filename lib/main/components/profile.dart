import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  String username = "";
  void getInfo() async {
    final prefs = await SharedPreferences.getInstance();
    username = (prefs.getString('username') ?? "");
    setState(() {
      username = username;
    });
  }

  void initState() {
    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3,
        title: Text('Profile', style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/gorgc.jpg'),
                radius: 80,
              ),
            ),
          ),
          Text(username, style: TextStyle(fontSize: 20))
        ],
      ),
    );
  }
}
