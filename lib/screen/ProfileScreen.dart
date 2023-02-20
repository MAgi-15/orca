import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orca/screen/EditProfile.dart';


class ProfileScreen extends StatefulWidget {

  @override
  State<ProfileScreen> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                          shape: BoxShape.circle
                      ),
                    ),
                    SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Text("Hallo,", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                        Text("SoulMaster69", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Text(
                  "Alex",
                  style: TextStyle(
                      fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 50,),
                Row(
                  children: [
                    InkWell(
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
                        width: 290,
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
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: (){},
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(right: 20),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: Colors.black38)
                        ),
                        child: Icon(
                          Iconsax.setting_25,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ),
          Container(
            height: 410,
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    height: 362,
                    child: TabBarView(
                        children: [
                          ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              itemCount: 4,
                              itemExtent: 350,
                              itemBuilder: (context, index){
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              itemCount: 4,
                              itemExtent: 350,
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
                        ]
                    ),
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