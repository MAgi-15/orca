import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:orca/main.dart';
import 'package:orca/service/DateFormat.dart';

import '../auth/ServiceAuth.dart';
import 'RegisterScreen.dart';


class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {

  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();

  bool hidden = true;

  bool isLoading = false;

  void errorAlert(BuildContext context, message){
    AlertDialog alert = AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.symmetric(horizontal: 15),
      title: Text("Error"),
      content: Container(child: Text(message, textAlign: TextAlign.center,),),
      actions: [
        ElevatedButton(
          onPressed: (){
            setState(() {
              Navigator.pop(context);
            });
          },
          child: Text("OKE", style: TextStyle(fontSize: 12),),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              fixedSize: Size(MediaQuery.of(context).size.width, 20)
          ),
        )
      ],
    );

    showDialog(context: context, builder: (context) => alert);
    return;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 40),
        children: [
          SizedBox(height: 120,),
          Center(
            child: Image.asset("assets/logo.png", alignment: Alignment.center,),
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
          Container(
            width: double.infinity,
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.email_outlined, size: 20,),
                SizedBox(width: 10,),
                Expanded(
                  child: TextField(
                    controller: EmailController,
                    decoration: InputDecoration(
                        hintText: "Email"
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline, size: 20,),
                SizedBox(width: 10,),
                Expanded(
                  child: TextField(
                    controller: PasswordController,
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
          ),
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    maximumSize: Size(70, 60)
                ),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  final message = await AuthService().login(
                      email: EmailController.text,
                      password: PasswordController.text
                  );
                  if(message!.contains('Success')){
                    await Future.delayed(Duration(seconds: 3));
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage())
                    );
                  } else {
                    errorAlert(context, message);
                  }

                  setState(() {
                    isLoading = false;
                  });
                },
                child: isLoading
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white,)
                    ),
                    const SizedBox(width: 20,),
                    Text("Mohon Tunggu...", style: TextStyle(color: Colors.white),)
                  ],
                )
                    : Text("Login", style: TextStyle(color: Colors.white))
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
    );
  }
}