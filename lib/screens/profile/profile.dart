import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gbv_break_the_cycle/configs/constants.dart';
import 'package:gbv_break_the_cycle/models/userProfileModel.dart';
import 'package:gbv_break_the_cycle/screens/home/home.dart';
import 'package:gbv_break_the_cycle/services/dataService.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FlutterSecureStorage storage = FlutterSecureStorage();
  DataService restAPI = DataService();
  UserProfileModel userProfileModel = UserProfileModel();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController cellNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
      nameController = TextEditingController(text: userProfileModel.name);
      surnameController = TextEditingController(text: userProfileModel.surname);
      genderController = TextEditingController(text: userProfileModel.gender);
      idNumberController = TextEditingController(text: userProfileModel.idNumber);
      cellNumberController = TextEditingController(text: userProfileModel.cellNumber);
      emailController = TextEditingController(text: userProfileModel.emailAddress);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Profile'),
          backgroundColor: Colors.blue,
      actions: <Widget>[
       IconButton(
          icon: Icon(
        Icons.check,
      ),
        onPressed: () {}, 
      ),
      ],
      leading: IconButton(
        icon: Icon(
        Icons.close,
      ),
        onPressed: () {
           Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home()));
        }, 
        ),
        ),
        body: SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                        child: TextFormField(
                      controller: nameController,
                      enabled: false,
                      validator: (val) =>
                          val.isEmpty ? 'Enter your name' : null,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    )),
                    breaker,
                    Container(
                        child: TextFormField(
                      controller: surnameController,
                      enabled: false,
                      validator: (val) =>
                          val.isEmpty ? 'Enter your surname' : null,
                      decoration: InputDecoration(
                        labelText: 'Surname',
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    )),
                    breaker,
                    Container(
                        child: TextFormField(
                      controller: genderController,
                      enabled: false,
                      validator: (val) =>
                          val.isEmpty ? 'Enter your Gender' : null,
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    )),
                    breaker,
                    Container(
                        child: TextFormField(
                      controller: idNumberController,
                      enabled: false,
                      validator: (val) =>
                          val.length < 13 ? 'Invalid Identity Number' : null,
                      decoration: InputDecoration(
                        labelText: 'ID Number',
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    )),
                    breaker,
                    Container(
                        child: TextFormField(
                      controller: cellNumberController,
                      enabled: false,
                      validator: (val) => val.length < 10
                          ? 'Cell Number must be 10 digits'
                          : null,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Cell Number',
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    )),
                    breaker,
                    Container(
                        child: TextFormField(
                      controller: emailController,
                      enabled: false,
                      validator: (value) => EmailValidator.validate(value)
                          ? null
                          : "Please enter a valid email",
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    )),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
