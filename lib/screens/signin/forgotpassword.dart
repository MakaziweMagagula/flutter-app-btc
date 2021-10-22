import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:gbv_break_the_cycle/configs/constants.dart';
import 'package:gbv_break_the_cycle/services/dataService.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DataService restAPI = DataService();
  final breaker = SizedBox(height: 10);

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
      title: Text('Reset Password'), 
      leading: new Container()),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                child: TextFormField(
                  controller: emailController,
                    validator: (value) => EmailValidator.validate(value) ? null : "Please enter a valid email",
                    keyboardType: TextInputType.emailAddress,
                     decoration: InputDecoration(
                        labelText: 'Email Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        prefixIcon: Icon(Icons.mail),
                        ),
                      ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Map<String, String> data = {
                            "emailAddress": emailController.text,
                          };
                          print(data);
                          restAPI.post("/user/forgot-password", data);
                        }
                      },
                child: Text('RESET',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(125, 15, 125, 15),
                            primary: rPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  //Methods

  //Reset Password
  resetPassword() async {
    Navigator.of(context).pop();
  }
}
