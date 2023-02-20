import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {

  final ListCategory = [
    'Games',
    'Sports',
    'Traveling',
    'Food',
    'Lainnya'
  ];


  int IndexCategory = 0;

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
                        child: Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: Colors.grey)
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
            height: 573,
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemCount: 4,
                itemExtent: 360,
                itemBuilder: (context, index){
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    margin: EdgeInsets.only(bottom: 10),
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
                            Text("SoulMaster69", style: TextStyle(color: Colors.grey),)
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text("Dek Clash Royale Terkuat Era Ini", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Icon(Iconsax.clock, size: 17,),
                            SizedBox(width: 5,),
                            Text("28 Februari 2022", style: TextStyle(fontSize: 13),)
                          ],
                        ),
                        SizedBox(height: 10,),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          height: 190,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/forum-40aed.appspot.com/o/asset%2Fimage%206.png?alt=media&token=f6015920-a79d-44ba-ab74-47a620f55b07"),
                              fit: BoxFit.fill
                            )
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              child: Row(
                                children: [
                                  Icon(Iconsax.message),
                                  SizedBox(width: 5,),
                                  Text("25", style: TextStyle(fontSize: 14),)
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
                }
            ),
          )
        ],
      )
    );
  }
}