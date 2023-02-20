import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:orca/main.dart';

import 'RegisterScreen.dart';


class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {

  final EmailController = TextEditingController();
  final PasswrordController = TextEditingController();

  bool hidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 100),
        child: ListView(
          children: [
            Center(
              child: Image.network("https://firebasestorage.googleapis.com/v0/b/forum-40aed.appspot.com/o/asset%2Flogo_login.png?alt=media&token=d3c963d4-2947-4c1a-bb2a-7c92a9547fe3", alignment: Alignment.center,),
            ),
            SizedBox(height: 50,),
            Text(
              "Log In",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 30,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.email_outlined, size: 20,),
                SizedBox(width: 10,),
                Container(
                  width: 270,
                  height: 60,
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Email"
                    ),
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline, size: 20,),
                SizedBox(width: 10,),
                SizedBox(
                  width: 270,
                  height: 60,
                  child: TextField(
                    obscureText: hidden,
                    decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              hidden = !hidden;
                            });
                          },
                          icon: Icon(
                            hidden == true
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye
                          ),
                        )
                    ),
                  ),
                )
              ],
            ),
           SizedBox(height: 40),
           InkWell(
             onTap: (){
               Navigator.push(
                   context, 
                   MaterialPageRoute(builder: (context) => MyHomePage())
               );
                   
             },
             child:
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 70),
                   alignment: Alignment.center,
                   height: 40,
                   decoration: BoxDecoration(
                     color: Colors.blue,
                     borderRadius: BorderRadius.circular(10)
                   ),
                   child: Text("Login", style: TextStyle(color: Colors.white),),
             ),
           ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Kamu belum punya akun?"),
                TextButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen())
                      );
                    },
                    child: Text("Sign Up")
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}