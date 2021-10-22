//import 'dart:ui';
import 'package:flutter/material.dart';
//import 'package:gbv_break_the_cycle/screens/login/signin.dart';
import 'package:gbv_break_the_cycle/components/mainDrawer.dart';
import 'package:gbv_break_the_cycle/screens/home/add_event.dart';
import 'package:gbv_break_the_cycle/screens/home/contacts.dart';
import 'package:gbv_break_the_cycle/screens/home/maps.dart';
import 'package:gbv_break_the_cycle/screens/home/dependents.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final tabs = [
    Center(child: Text('Home', style: TextStyle(fontSize: 30))),
    GoogleMapScreen(),
    EventScreen(),
    ContactsPage(),
    Center(child: Text('Nofitications', style: TextStyle(fontSize: 30))),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Break The Cycle'),
          backgroundColor: Colors.blue,
        ),
        drawer: MainDrawer(),
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.map_sharp),
                label: 'Maps',
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box),
                label: 'Event',
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'Friends',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notifications',
                backgroundColor: Colors.blue),
          ],
          onTap: (index) {
            setState(()  {
              _currentIndex = index;

              //if(_currentIndex == 3)
              //{
               // final PermissionStatus permissionStatus = await _getPermission();
              //if (permissionStatus == PermissionStatus.granted) {
                //Navigator.push(context,
                  //  MaterialPageRoute(builder: (context) => ContactsPage()));
              //} else {
               // _currentIndex = index;
              //}
              //}
              
            });
          },
      
      ),
    ),
    );
  }

  //Check contacts permission
  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.limited;
    } else {
      return permission;
    }
  }
}
