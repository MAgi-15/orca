import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:orca/service/DateFormat.dart';

class Comment extends StatefulWidget {
  final keys;
  const Comment({Key? key, required this.keys}) : super(key: key);

  @override
  State<Comment> createState() => _CommnetState(keys);
}

class _CommnetState extends State<Comment> {
  final keys;

  _CommnetState(this.keys);

  final fDatabaseContent = FirebaseDatabase.instance.ref().child("list_content");

  String? name;
  String? image;

  var CommentController = TextEditingController();

  Future<Map?> getUserData(userId) async {
  var username = await FirebaseDatabase.instance.ref().child('user').child(userId).child('profile').child('username').once();
  var images = await FirebaseDatabase.instance.ref().child('user').child(userId).child('profile').child('images').once();

  return {'username': username.snapshot.value.toString(), 'image': images.snapshot.value.toString()};
  }

  Future<void> saveComment() async {

    final userId = await FirebaseAuth.instance.currentUser!.uid;

    await fDatabaseContent.child(keys).child('comment').push().set({
      'userId' : userId,
      'comment' : CommentController.text,
      'tanggal' : DateFormatter.formatDate(DateTime.now())
     });

    setState(() {
      CommentController.text = "";
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.only(right: 2),
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black
            ),
            child: Icon(CupertinoIcons.back, color: Colors.white, size: 20,),
          ),
        ),
        centerTitle: true,
        title: Text("Comment", style: TextStyle(color: Colors.black),),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: FirebaseAnimatedList(
          query: fDatabaseContent.child(keys).child('comment'),
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map comment = snapshot.value as Map;
            var userId = comment['userId'];

            return FutureBuilder(
              future: getUserData(userId),
              builder: (BuildContext context, AsyncSnapshot<Map?> userDataSnapshot) {
                if (userDataSnapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox();
                }
                if (userDataSnapshot.hasData) {
                  var userData = userDataSnapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(userData['image'] ?? ''),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 100,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            decoration: BoxDecoration(
                                color: Color(0xffF5F5F5),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(userData['username'] ?? '',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(comment['comment'] ?? ''),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(comment['tanggal'] ?? '', style: TextStyle(fontSize: 12, color: Colors.black),)
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10,)
                    ],
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 0.5,
              color: Colors.black.withOpacity(0.5),
            )
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            color: Color(0xffF5F5F5)
          ),
          child: Row(
            children: [
             Container(
                 width: MediaQuery.of(context).size.width - 80,
                 height: 100,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10)
                 ),
                 child: TextField(
                   controller: CommentController,
                   style: TextStyle(
                     fontSize: 15
                   ),
                   decoration: InputDecoration(
                     hintText: "Tambahkan Komentar",
                     border: InputBorder.none,
                     focusedBorder: InputBorder.none,
                   ),
                 )
             ),
              InkWell(
                onTap: (){
                  saveComment();
                },
                child: Icon(
                  Icons.send,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
