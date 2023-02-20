import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


class AddScreen extends StatefulWidget {

  @override
  State<AddScreen> createState() => _AddState();
}

class _AddState extends State<AddScreen> {

  String dropdownValue = 'Option 1';



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
                onPressed: (){},
                child: Text("Share")
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){},
              child: DottedBorder(
                  strokeWidth: 1,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
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
                    items: <String>['Option 1', 'Option 2', 'Option 3']
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
                decoration: InputDecoration(
                  hintText: "Judul"
                ),
              ),
            ),
            SizedBox(height: 40,),
            Container(
              width: double.infinity,
              height: 20,
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Deskripsi"
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}