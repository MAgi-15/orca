import 'dart:core';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orca/screen/CommentScreen.dart';
import 'package:orca/screen/DetailScreen.dart';


class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {

  final userId = FirebaseAuth.instance.currentUser!.uid;

  final ListCategory = [
    'Semua',
    'Games',
    'Sports',
    'Traveling',
    'Food',
    'Lainnya'
  ];

  final fDatabaseContent = FirebaseDatabase.instance.ref().child("list_content");

  var searchController = TextEditingController();
  String _searchText = "";


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

  Future<void> save(keys, username, judul, image, time, comment) async {
    await FirebaseDatabase.instance.ref().child('user').child(userId).child('bookmark').child(keys).set({
      'userName': username,
      'judul_content': judul,
      'images': image,
      'date_time': time,
      'comment': comment
    });

    successAlert(context);
  }



  int? IndexCategory;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leadingWidth: double.infinity,
        title: Container(
          padding: EdgeInsets.fromLTRB(20, 3, 0, 3),
          width: MediaQuery.of(context).size.width,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(width:0.5, color: Colors.grey),
            borderRadius: BorderRadius.circular(10)
          ),
          child: TextField(
            controller: searchController,
            onChanged: (value){
              setState(() {
                _searchText = value;
              });
            },
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "Cari",
              suffixIcon: Icon(Iconsax.search_normal_1, size: 16, color: Colors.black,)
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: ListCategory.length,
                itemBuilder: (context, index){
                  return Row(
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            IndexCategory = index;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: IndexCategory == index ? Colors.black : Colors.grey)
                          ),
                          child: Text(ListCategory[index]),
                        ),
                      ),
                      SizedBox(width: 10,)
                    ],
                  );
                }
            ),
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            height: 570,
            child: FirebaseAnimatedList(
                defaultChild: Center(child: CircularProgressIndicator(),),
                query: fDatabaseContent,
                itemBuilder: (context, snapshot, animation, index){
                  Map content = snapshot.value as Map;
                  content['key'] = snapshot.key;

                  var profile = content['userName'];
                  var tanggal = content['date_time'];
                  var image = content['image'];
                  var judul = content['judul_content'];
                  var kategori = content['kategori'];
                  var comment = content['comment'];

                  if (_searchText.isNotEmpty) {
                    if (!judul.toLowerCase().contains(_searchText.toLowerCase())) {
                      return SizedBox();
                    }
                  }

                  if(IndexCategory != null){
                    if(ListCategory[IndexCategory!] != "Semua"){
                      if (!kategori.toLowerCase().contains(ListCategory[IndexCategory!].toLowerCase())) {
                        return SizedBox();
                      }
                    }
                  }

                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(keys: content['key'])));
                    },
                    child: Container(
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
                                  save(
                                      content['key'],
                                      profile,
                                      judul,
                                      image,
                                      tanggal,
                                      comment
                                  );
                                },
                                child: Icon(Icons.bookmark_border),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      )
    );
  }
}