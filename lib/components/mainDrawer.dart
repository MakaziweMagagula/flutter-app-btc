import 'package:flutter/material.dart';
import 'package:gbv_break_the_cycle/models/userProfileModel.dart';
import 'package:gbv_break_the_cycle/components/about.dart';
import 'package:gbv_break_the_cycle/screens/profile/profile.dart';
import 'package:gbv_break_the_cycle/components/settings.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gbv_break_the_cycle/screens/signin/signin.dart';
import 'package:gbv_break_the_cycle/services/dataService.dart';
//import 'package:gbv_break_the_cycle/screens/home/mainDrawer.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  FlutterSecureStorage storage = FlutterSecureStorage();
  DataService restAPI = DataService();
  UserProfileModel userProfileModel = UserProfileModel();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    this.fetchUserDetails();
  }

  fetchUserDetails() async {
    String userId = await storage.read(key: "id");
    var response =
        await restAPI.getDependents("/user/get-user-details/" + userId);

    setState(() {
      userProfileModel = UserProfileModel.fromJson(response["data"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    var fullName = userProfileModel.name.toString()+
        " " +
        userProfileModel.surname.toString();
    var email = userProfileModel.emailAddress.toString();
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(50),
            color: Theme.of(context).primaryColor,
            child: Column(
              children: <Widget>[
                Text(
                  fullName,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                Text(
                  email,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Profile',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'History',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings()));
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text(
              'About',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => About()));
            },
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () async {
              await storage.delete(key: "token");
              Navigator.of(context).pop();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignIn()));
            },
          ),
        ],
      ),
    );
  }
}
