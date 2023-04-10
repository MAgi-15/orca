import 'dart:io';
import 'dart:async';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orca/service/DateFormat.dart';
import 'package:path/path.dart';


class AddScreen extends StatefulWidget {

  @override
  State<AddScreen> createState() => _AddState();
}

class _AddState extends State<AddScreen> {

  File? image;

  String dropdownValue = 'Semua';
  final fDatabaseContent = FirebaseDatabase.instance.ref().child("list_content");

  var JudulController = TextEditingController();
  var DeskripsiController = TextEditingController();

  Future openGaleri() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedImage!.path);
    });
    uploadFotoProfile();
  }

  Future uploadFotoProfile() async {
    String fileName = basename(image!.path);
    await FirebaseStorage.instance.ref().child('content/$fileName').putFile(image!);
    var url = await FirebaseStorage.instance.ref().child('content/$fileName').getDownloadURL();
    setState(() {
      urlImage = url.toString();
    });
  }

  String? urlImage;

  Future<void> saveData() async {

    var user = await FirebaseAuth.instance.currentUser!; 
    var username = await FirebaseDatabase.instance.ref().child('user').child(user.uid).child('profile').child('username').once();

    fDatabaseContent.push().set({
      'userid' : user.uid.toString(),
      'userName' : username.snapshot.value.toString(),
      'judul_content' : JudulController.text ,
      'deskripsi' : DeskripsiController.text,
      'kategori' : dropdownValue  ,
      'image' : urlImage  ,
      'date_time' : DateFormatter.formatDate(DateTime.now())  ,
      'comment' : {}  ,
    });

  }

  void successAlert(BuildContext context) {
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
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20, top: 10, bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  maximumSize: Size(120, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                onPressed: (){
                  saveData();
                  successAlert(context);
                },
                child: Text("Share")
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: ListView(
          children: [
            InkWell(
              onTap: (){
                openGaleri();
              },
              child: DottedBorder(
                  strokeWidth: 1,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: image == null
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                        )
                        : BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(image!),
                        fit: BoxFit.cover
                      )
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.upload),
                        Text("Upload Gambar")
                      ],
                    ),
                  )
              ),
            ),
                SizedBox(height: 35,),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    hint: Text("Kategori"),
                    icon: Icon(Iconsax.arrow_down_1),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.black,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Semua','Games', 'Sports', 'Traveling', 'Food']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
            SizedBox(height: 40,),
            Container(
              width: double.infinity,
              height: 20,
              child: TextField(
                controller: JudulController,
                decoration: InputDecoration(
                  hintText: "Judul"
                ),
              ),
            ),
            SizedBox(height: 40,),
            Container(
              width: double.infinity,
              height: 70,
              child: TextField(
                controller: DeskripsiController,
                maxLines: 2,
                decoration: InputDecoration(
                    hintText: "Deskripsi",
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}