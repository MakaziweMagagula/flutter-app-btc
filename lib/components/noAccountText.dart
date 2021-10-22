import 'package:flutter/material.dart';
import 'package:gbv_break_the_cycle/screens/signup/signup.dart';
import 'package:gbv_break_the_cycle/configs/constants.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
        ),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp())),
          child: Text(
            "Sign Up",
            style: TextStyle(
              color: bPrimaryColor,
              decoration: TextDecoration.underline
            )
            
          ),
        ),
      ],
    );
  }
}

