import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orca/screen/CommentScreen.dart';


class DetailScreen extends StatefulWidget {
  final keys;

  const DetailScreen({super.key, required this.keys});

  @override
  State<DetailScreen> createState() => _DetailState(keys);
}

class _DetailState extends State<DetailScreen> {

  final keys;
  _DetailState(this.keys);

  final fDatabase = FirebaseDatabase.instance.ref().child('list_content');

  String? judul;
  String? username;
  String? userId;
  String? tanggal;
  String? images;
  var comment;
  String? kategori;
  String? deskripsi;

  bool loading = false;

  Future<void> getDataContent() async {

    setState(() {
      loading = true;
    });

    var judulSnapshot = await fDatabase.child(keys).child('judul_content').once();
    var usernameSnapshot = await fDatabase.child(keys).child('username').once();
    var tanggalSnapshot = await fDatabase.child(keys).child('date_time').once();
    var imagesSnapshot = await fDatabase.child(keys).child('image').once();
    var commentSnapshot = await fDatabase.child(keys).child('comment').once();
    var kategoriSnapshot = await fDatabase.child(keys).child('kategori').once();
    var deskripsiSnapshot = await fDatabase.child(keys).child('deskripsi').once();
    var userIdSnapshot = await fDatabase.child(keys).child('userid').once();


    setState(() {
      judul = judulSnapshot.snapshot.value.toString();
      username = usernameSnapshot.snapshot.value.toString();
      tanggal = tanggalSnapshot.snapshot.value.toString();
      images = imagesSnapshot.snapshot.value.toString();
      comment = commentSnapshot.snapshot.value;
      kategori = kategoriSnapshot.snapshot.value.toString();
      deskripsi = deskripsiSnapshot.snapshot.value.toString();
      userId = userIdSnapshot.snapshot.value.toString();
    });

    var userSnapshot = await FirebaseDatabase.instance.ref().child('user').child(userId!).child("profile").child('username').once();

    setState(() {
      username = userSnapshot.snapshot.value.toString();
    });

    setState(() {
      loading = false;
    });
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

  Future<void> save(keys, username, judul, image, time, comment) async {
    await FirebaseDatabase.instance.ref().child('user').child(userId!).child('bookmark').child(keys).set({
      'userName': username,
      'judul_content': judul,
      'images': image,
      'date_time': time,
      'comment': comment
    });

    successAlert(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataContent();
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
        title: Text("Content", style: TextStyle(color: Colors.black, ),),
      ),
      body: loading
        ? Center(child: CircularProgressIndicator(),)
        : ListView(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        children: [
          Text(judul!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
          SizedBox(height: 10,),
          Text("By " + username! + " ● " + tanggal!),
          SizedBox(height: 10,),
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              image: DecorationImage(
                image: NetworkImage(images!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Comment(keys: keys,)));
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
                      keys,
                      username,
                      judul,
                      images,
                      tanggal,
                      comment
                  );
                },
                child: Icon(Icons.bookmark_border),
              )
            ],
          ),
          SizedBox(height: 10,),
          Text(kategori!),
          SizedBox(height: 10,),
          Text(deskripsi!)
        ],
      ),
    );
  }
}