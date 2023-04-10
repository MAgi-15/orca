import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orca/screen/CommentScreen.dart';
import 'package:orca/screen/EditProfile.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';


class ProfileScreen extends StatefulWidget {

  @override
  State<ProfileScreen> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  final userId = FirebaseAuth.instance.currentUser!.uid;
  final fDatabaseProfile = FirebaseDatabase.instance.ref().child('user');

  bool loading = false;
  String? username;
  String? image;



  Future<void> getData() async {
    setState(() {
      loading = true;
    });

    var user = await FirebaseAuth.instance.currentUser!;

    var name = await fDatabaseProfile.child(user.uid).child('profile').child(
        'username').once();
    var images = await fDatabaseProfile.child(user.uid).child('profile').child(
        'images').once();

    setState(() {
      username = name.snapshot.value.toString();
      image = images.snapshot.value.toString();
    });

    setState(() {
      loading = false;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(child: CircularProgressIndicator(),)
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(left: 25, right: 25, top: 70),
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(image!),
                            fit: BoxFit.cover
                          )
                        ),
                      ),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20,),
                          Text("Hallo,", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                          Text(username!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  SizedBox(height: 50,),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditProfile())
                          );
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: 10),
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1, color: Colors.black38)
                          ),
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                            right: 5
                          ),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1, color: Colors.black38)
                          ),
                          child: Icon(
                            Iconsax.logout5,
                            size: 20,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
          ),
          Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                        unselectedLabelColor: Colors.black,
                        labelColor: Colors.black,
                        indicatorColor: Colors.black,
                        labelStyle: TextStyle(
                            fontSize: 17,
                            color: Colors.black
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        tabs: [
                          Tab(icon: Icon(Icons.list),),
                          Tab(icon: Icon(Icons.bookmark_border),),
                        ]
                    ),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: TabBarView(
                              children: [
                                FirebaseAnimatedList(
                                    defaultChild: Center(child: CircularProgressIndicator(),),
                                    query: FirebaseDatabase.instance.ref().child('list_content').orderByChild('userid').equalTo(userId),
                                    itemBuilder: (context, snapshot, animation, index){
                                      Map content = snapshot.value as Map;
                                      content['key'] = snapshot.key;

                                      var profile = content['userName'];
                                      var tanggal = content['date_time'];
                                      var image = content['image'];
                                      var judul = content['judul_content'];
                                      var comment = content['comment'];


                                      return Container(
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                        margin: EdgeInsets.only(bottom: 10, left:3, right: 3, top: 2 ),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                  spreadRadius: 1,
                                                  offset: Offset(1,0.5),
                                                  color: Colors.grey.shade400,
                                                  blurRadius: 3
                                              )
                                            ]
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(profile, style: TextStyle(color: Colors.grey),),
                                                InkWell(
                                                  onTap: () async {
                                                    await FirebaseDatabase.instance.ref().child('list_content').child(content['key']).remove();
                                                    successAlert(context);
                                                  },
                                                  child: Icon(CupertinoIcons.trash_circle_fill, size: 25,),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Text(judul, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                            SizedBox(height: 10,),
                                            Row(
                                              children: [
                                                Icon(Iconsax.clock, size: 17,),
                                                SizedBox(width: 5,),
                                                Text(tanggal, style: TextStyle(fontSize: 13),)
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Container(
                                              margin: EdgeInsets.only(bottom: 10),
                                              height: 190,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      image: NetworkImage(image),
                                                      fit: BoxFit.fill
                                                  )
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Comment(keys: content['key'],)));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(Iconsax.message),
                                                      SizedBox(width: 5,),
                                                      Text(comment == null ? "0" : comment.length.toString(), style: TextStyle(fontSize: 14),)
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  child: Icon(Icons.bookmark_border),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                                FirebaseAnimatedList(
                                    defaultChild: Center(child: CircularProgressIndicator(),),
                                    query: FirebaseDatabase.instance.ref().child('user').child(userId).child('bookmark'),
                                    itemBuilder: (context, snapshot, animation, index){
                                      Map content = snapshot.value as Map;
                                      content['key'] = snapshot.key;

                                      var profile = content['userName'];
                                      var tanggal = content['date_time'];
                                      var image = content['images'];
                                      var judul = content['judul_content'];
                                      var comment = content['comment'];

                                      return Container(
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                        margin: EdgeInsets.only(bottom: 10, left:3, right: 3, top: 2 ),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                  spreadRadius: 1,
                                                  offset: Offset(1,0.5),
                                                  color: Colors.grey.shade400,
                                                  blurRadius: 3
                                              )
                                            ]
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(profile, style: TextStyle(color: Colors.grey),)
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Text(judul, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                            SizedBox(height: 10,),
                                            Row(
                                              children: [
                                                Icon(Iconsax.clock, size: 17,),
                                                SizedBox(width: 5,),
                                                Text(tanggal, style: TextStyle(fontSize: 13),)
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Container(
                                              margin: EdgeInsets.only(bottom: 10),
                                              height: 190,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      image: NetworkImage(image),
                                                      fit: BoxFit.fill
                                                  )
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Comment(keys: content['key'],)));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(Iconsax.message),
                                                      SizedBox(width: 5,),
                                                      Text(comment == null ? "0" : comment.length.toString(), style: TextStyle(fontSize: 14),)
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: (){
                                                    FirebaseDatabase.instance.ref().child('user').child(userId).child('bookmark').child(content['key']).remove();
                                                  },
                                                  child: Icon(Icons.bookmark, color: Colors.black,),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ]
                          ),
                        )
                    )
                  ],
                ),
              ),
          )
        ],
      )
    );
  }
}