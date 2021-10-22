import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:gbv_break_the_cycle/configs/constants.dart';
import 'package:gbv_break_the_cycle/screens/signin/signin.dart';
import 'package:gbv_break_the_cycle/services/dataService.dart';
//import 'package:gbv_break_the_cycle/screens/home/home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ProgressDialog progressDialog;
  DataService restAPI = DataService();
  final breaker = SizedBox(height: 10);
  String errorText;
  bool validate = false;
  final storage = new FlutterSecureStorage();

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController cellNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String gender = 'Select Gender';

  List<String> genders = ['Male', 'Female'];

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
        body: SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              child: Image(
                image: AssetImage("assets/images/btc.png"),
                fit: BoxFit.none,
              ),
            ),
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                        child: TextFormField(
                      controller: nameController,
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
                    DropdownSearch(
                      items: genders,
                      //label: "Gender",
                      onChanged: (String data) {
                        setState(() {
                          gender = data;
                        });
                      },
                      selectedItem: gender,
                      maxHeight: 120,
                      mode: Mode.MENU,
                      validator: (String item) {
                        if (item == null)
                          return "Required field";
                        else
                          return null;
                      },
                      dropdownSearchDecoration: InputDecoration(
                         border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(0),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                      ) ,
                    ),
                    breaker,
                    Container(
                        child: TextFormField(
                      controller: idNumberController,
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
                    breaker,
                    Container(
                        child: TextFormField(
                      controller: passwordController,
                      validator: (val) => val.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            this.showPassword
                                ? Icons.remove_red_eye
                                : Icons.remove_red_eye_outlined,
                            color:
                                this.showPassword ? Colors.blue : Colors.grey,
                          ),
                          onPressed: () {
                            setState(
                                () => this.showPassword = !this.showPassword);
                          },
                        ),
                      ),
                      obscureText: !this.showPassword,
                    )),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: signUp,
                      child: Text('SIGN UP',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(125, 10, 125, 10),
                        primary: rPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

//Methods
//Verify Sign Up
  signUp() async {
    if (_formKey.currentState.validate()) {
      Map<String, dynamic> data = {
        "name": nameController.text,
        "surname": surnameController.text,
        "gender": gender,
        "idNumber": idNumberController.text,
        "cellNumber": cellNumberController.text,
        "emailAddress": emailController.text,
        "password": passwordController.text,
      };
      print(data);
      if (data != null) {
        var response = await restAPI.postRegister("/user/sign-up", data);
        if (response.statusCode == 200 || response.statusCode == 201) {
          _showcontent();
          
        }
      } else {
        print("Error");
      }
    }
  }

  //Pop up Dialog
  void _showcontent() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Successfully Signed Up'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text('Click OK to Proceed'),
              ],
            ),
          ),
          actions: [
            new GestureDetector(
              child: new Text('Ok'),
              onTap: () {
                Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignIn()));
              },
            ),
          ],
        );
      },
    );
  }
}
