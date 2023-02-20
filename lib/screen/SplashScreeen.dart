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
            Image.network("https://firebasestorage.googleapis.com/v0/b/forum-40aed.appspot.com/o/asset%2Flogo_login.png?alt=media&token=d3c963d4-2947-4c1a-bb2a-7c92a9547fe3"),
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