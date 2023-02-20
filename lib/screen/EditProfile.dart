import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orca/screen/LoginScreen.dart';


class EditProfile extends StatefulWidget {

  @override
  State<EditProfile> createState() => _EditState();
}

class _EditState extends State<EditProfile> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Iconsax.arrow_circle_left5, color: Colors.black,),
        ),
        centerTitle: true,
        title: Text("Edit Profile", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            SizedBox(height: 40,),
            Center(
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle
                ),
              ),
            ),
            SizedBox(height: 50,),
            Container(
              width: double.infinity,
              height: 30,
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Username"
                ),
              ),
            ),
            SizedBox(height: 50,),
            Container(
              width: double.infinity,
              height: 30,
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Email"
                ),
              ),
            ),
            SizedBox(height: 50,),
            Container(
              width: double.infinity,
              height: 30,
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Password"
                ),
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width, 40)
                ),
                onPressed: (){},
                child: Text("Save")
            )
          ],
        ),
      )
    );
  }
}