import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
 Future checkFirstSeen() async {
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Image(image: AssetImage("assets/images/start.jpg"),) ,
              ),

            RichText(
              text: TextSpan(
                text: 'Welcome to ', 
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.black),

                children: <TextSpan>[
                  TextSpan(
                    text: 'GBV App',
                     style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.red)
                  )
                ]
              )
              ), 
              Text('Break The Cycle of GBV',
               style: TextStyle(color: Colors.black) ,)
          ],
        )
      )
      
    );
  }
}
