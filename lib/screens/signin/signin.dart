import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:gbv_break_the_cycle/screens/signin/forgotpassword.dart';
import 'package:gbv_break_the_cycle/services/dataService.dart';
import 'package:gbv_break_the_cycle/screens/home/home.dart';
import 'package:gbv_break_the_cycle/configs/constants.dart';
import 'package:gbv_break_the_cycle/components/noAccountText.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ProgressDialog progressDialog;
  DataService restAPI = DataService();
  FlutterSecureStorage storage = FlutterSecureStorage();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String errorText;
  bool validate = false;

  bool showPassword = false;
  String error = 'Testing error';

  @override
  void initState() {
    super.initState();
  }

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
                height: 250,
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
                          prefixIcon: Icon(Icons.mail),
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
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              this.showPassword
                                  ? Icons.remove_red_eye
                                  : Icons.remove_red_eye_outlined,
                              color: this.showPassword
                                  ? bPrimaryColor
                                  : gPrimaryColor,
                            ),
                            onPressed: () {
                              setState(
                                  () => this.showPassword = !this.showPassword);
                            },
                          ),
                        ),
                        obscureText: !this.showPassword,
                      )),
                      SizedBox(height: 5),
                      Container(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          child: Text('Forgot Password?',
                              style: TextStyle(
                                  color: bPrimaryColor,
                                  fontWeight: FontWeight.bold)),
                          onTap: navigateToForgotPassword,
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                          onPressed: login,
                          child: Text('SIGN IN',
                              style: TextStyle(
                                  color: wPrimaryColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(125, 15, 125, 15),
                            primary: rPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              breaker,
              NoAccountText(),
            ],
          ),
        ),
      ),
    );
  }

  //Verify Sign In
  login() async {
    progressDialog.show();
    if (_formKey.currentState.validate()) {
      Map<String, dynamic> data = {
        "emailAddress": emailController.text,
        "password": passwordController.text,
      };
      print(data);
      var response = await restAPI.post("/user/sign-in", data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> output = json.decode(response.body);
        print(output['token']);
        print(output['id']);
        await storage.write(key: "token", value: output["token"]);
        await storage.write(key: "id", value: output['id'].toString());
        checkAuthentication();
        setState(() {
          validate = true;
        });
      } else {
        String output = json.decode(response.body);
        setState(() {
          validate = false;
          errorText = output;
        });
      }
    }
  }

//Show Error Dialog
  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

//Link to Forgot Password Screen
  navigateToForgotPassword() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgotPassword()));
  }

//Check User if they have logged in or not
  checkAuthentication() async {
    progressDialog.hide();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }
}
