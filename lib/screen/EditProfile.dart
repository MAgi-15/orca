import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orca/screen/LoginScreen.dart';
import 'package:path/path.dart';


class EditProfile extends StatefulWidget {

  @override
  State<EditProfile> createState() => _EditState();
}

class _EditState extends State<EditProfile> {

  final fDatabaseProfile = FirebaseDatabase.instance.ref().child('user');
  final fStorage = FirebaseStorage.instance;

  File? image;

  var NameController = TextEditingController();
  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();

  String? images_url;

  bool loading = false;

  Future openCamera() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      image = File(pickedImage!.path);
    });
    uploadFotoProfile();
  }
  Future openGaleri() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedImage!.path);
    });
    uploadFotoProfile();
  }

  Future uploadFotoProfile() async {
    var user = await FirebaseAuth.instance.currentUser!;
    String fileName = basename(image!.path);
    await fStorage.ref().child('profile/$fileName').putFile(image!);
    var url = await fStorage.ref().child('profile/$fileName').getDownloadURL();
    FirebaseDatabase.instance.ref().child("user").child(user.uid).child('profile').child('images').set(url.toString());
    setState(() {
      images_url = url;
    });
  }

  Future<void> getData() async {
    setState(() {
      loading = true;
    });

    var user = await FirebaseAuth.instance.currentUser!;

    var name = await fDatabaseProfile.child(user.uid).child('profile').child('username').once();
    var email = user.email;
    var url = await fDatabaseProfile.child(user.uid).child('profile').child('images').once();

    setState(() {
      NameController.text = name.snapshot.value.toString();
      EmailController.text = email.toString();
      images_url = url.snapshot.value.toString();
    });

    setState(() {
      loading = false;
    });
  }

  Future<void> saveData() async {
    var user = await FirebaseAuth.instance.currentUser!;
    await fDatabaseProfile.child(user.uid).child('profile').set({
      'username' : NameController.text,
      'email' : EmailController.text,
      'images' : images_url
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void successAlert(BuildContext context){
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Icon(Icons.check_circle, color: Colors.green, size: 50),
      content: Text("Sukses Menyimpan"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK'),
        ),
      ],
    );

    showDialog(context: context, builder: (context) => alert);
    return;
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
      body: loading
        ? Center(child: CircularProgressIndicator(),)
          : Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: ListView(
              children: [
                SizedBox(height: 40,),
                Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(images_url!),
                                fit: BoxFit.fill
                              ),
                              color: Colors.grey,
                              shape: BoxShape.circle
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            showModalBottomSheet(
                                context: context,
                                builder: ((builder) => Container(
                                  height: 150,
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Color(0xedededed),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Foto Profil", style: TextStyle(fontSize: 20),),
                                      SizedBox(height: 20,),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                              onPressed: (){
                                                openCamera();
                                                Navigator.pop(context);
                                              },
                                              child: Icon(Iconsax.camera, color: Colors.black,),
                                              style: ElevatedButton.styleFrom(
                                                  shape: CircleBorder(side: BorderSide(color: Colors.black)),
                                                  fixedSize: Size(60, 60),
                                                  primary: Colors.transparent,
                                                  elevation: 0
                                              )
                                          ),
                                          SizedBox(width: 20,),
                                          ElevatedButton(
                                              onPressed: (){
                                                openGaleri();
                                                Navigator.pop(context);
                                              },
                                              child: Icon(Iconsax.gallery, color: Colors.black,),
                                              style: ElevatedButton.styleFrom(
                                                  shape: CircleBorder(side: BorderSide(color: Colors.black)),
                                                  fixedSize: Size(60, 60),
                                                  primary: Colors.transparent,
                                                  elevation: 0
                                              )
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                                )
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10, right: 3),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black
                            ),
                            child: Icon(Iconsax.add, color: Colors.white, size: 20,),
                          ),
                        )
                      ],
                    )
                ),
                SizedBox(height: 50,),
                Container(
                  width: double.infinity,
                  height: 30,
                  child: TextField(
                    controller: NameController,
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
                    controller: EmailController,
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
                    onPressed: (){
                      saveData();
                      successAlert(context);
                    },
                    child: Text("Save")
                )
              ],
            ),
          )
    );
  }
}