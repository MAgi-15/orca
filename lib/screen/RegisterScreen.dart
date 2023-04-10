import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orca/main.dart';
import 'package:orca/screen/LoginScreen.dart';

import '../auth/ServiceAuth.dart';


class RegisterScreen extends StatefulWidget {

  @override
  State<RegisterScreen> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen> {

  final EmailController = TextEditingController();
  final NamaController = TextEditingController();
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
        body: Padding(
          padding: EdgeInsets.only(left: 40, right: 40, top: 100),
          child: ListView(
            children: [
              Center(
                child: Image.asset("assets/logo.png", alignment: Alignment.center,),
              ),
              SizedBox(height: 50,),
              Text(
                "Sign Up",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 40,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Iconsax.user, size: 20,),
                  SizedBox(width: 10,),
                  Expanded(
                      child: TextField(
                        controller: NamaController,
                        decoration: InputDecoration(
                            hintText: "Username"
                        ),
                      ),
                  )
                ],
              ),
              Row(
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
              Row(
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
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        maximumSize: Size(70, 50)
                    ),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      final message = await AuthService().registration(
                          username: NamaController.text,
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
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(color: Colors.white,)
                        ),
                        const SizedBox(width: 20,),
                        Text("Mohon Tunggu...", style: TextStyle(color: Colors.white),)
                      ],
                    )
                        : Text("Sign Up", style: TextStyle(color: Colors.white))
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
                            MaterialPageRoute(builder: (context) => LoginScreen())
                        );
                      },
                      child: Text("Sign In")
                  )
                ],
              ),
            ],
          ),
        )
    );
  }
}