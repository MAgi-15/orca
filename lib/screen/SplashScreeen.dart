import 'dart:async';

import 'package:flutter/material.dart';
import 'package:orca/screen/LoginScreen.dart';


class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _LoginState();
}

class _LoginState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 3),
            ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png'),
            Text(
              "O.R.C.A",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50
              ),
            ),
            Text("Online Free Community Application")
          ],
        ),
      )
    );
  }
}