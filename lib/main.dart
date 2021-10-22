import 'package:flutter/material.dart';
import 'package:gbv_break_the_cycle/screens/home/home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gbv_break_the_cycle/screens/signin/signin.dart';

import 'configs/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = SignIn();
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    checkLogin();
  }
  
  //Validate Token
  void checkLogin() async {
    String token = await storage.read(key: "token");
    if (token != null) {
      setState(() {
        page = Home();
      });
    } else {
      setState(() {
        page = SignIn();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Break The Cycle',
      theme: ThemeData(
          primaryColor: gPrimaryColor,
         scaffoldBackgroundColor: wPrimaryColor),
      home: page,
    );
  }
}
