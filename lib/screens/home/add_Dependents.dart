import 'package:flutter/material.dart';
import 'package:gbv_break_the_cycle/screens/home/home.dart';
import 'package:gbv_break_the_cycle/services/dataService.dart';

class AddDependents extends StatefulWidget {
  @override
  _AddDependentsState createState() => _AddDependentsState();
}

class _AddDependentsState extends State<AddDependents> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DataService restAPI = DataService();
  final breaker = SizedBox(height: 10);

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController cellNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(centerTitle: true,
      title: Text('Add Dependents'),
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
        )
       ),
       body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                child: TextFormField(
                  controller: nameController,
                    validator: (val) => val.isEmpty ? 'Enter your name' : null,
                    keyboardType: TextInputType.emailAddress,
                     decoration: InputDecoration(
                        //hintText: "Enter your Email Address",
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                        ),
                        //prefixIcon: Icon(Icons.person),
                      ),
              ),
              SizedBox(height: 20),
              Container(
                child: TextFormField(
                  controller: surnameController,
                    validator: (val) => val.isEmpty ? 'Enter your surname' : null,
                    keyboardType: TextInputType.emailAddress,
                     decoration: InputDecoration(
                        //hintText: "Enter your Email Address",
                        labelText: 'Surname',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                        ),
                        //prefixIcon: Icon(Icons.person),
                      ),
              ),
              SizedBox(height: 20),
              Container(
                child: TextFormField(
                  controller: cellNumberController,
                    validator: (val) => val.length < 10
                          ? 'Cell Number must be 10 digits'
                          : null,
                    keyboardType: TextInputType.emailAddress,
                     decoration: InputDecoration(
                        //hintText: "Enter your Email Address",
                        labelText: 'Cell Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                        ),
                        //prefixIcon: Icon(Icons.person),
                      ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                
                onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Map<String, String> data = {
                            "name": nameController.text,
                            "surname": surnameController.text,
                            "cellNumber": cellNumberController.text,
                          };
                          print(data);
                          restAPI.post("/dependent/add-dependents", data);
                          Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home()));
                        }
                      },
                child: Text('Add Dependent',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                  primary : Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                )
                
              )
            ],
          ),
        ),
      ),
    );
      
  }
}