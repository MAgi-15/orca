import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orca/screen/AddScreen.dart';
import 'package:orca/screen/HomeScreen.dart';
import 'package:orca/screen/LoginScreen.dart';
import 'package:orca/screen/ProfileScreen.dart';
import 'package:orca/screen/SplashScreeen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override

  State<MyHomePage> createState() => _MyHomePageState();
  }

  class _MyHomePageState extends State<MyHomePage> {

  int pageIndex = 0;

  final ListPage =[
    HomeScreen(),
    AddScreen(),
    ProfileScreen(),
  ];

  void updateIndex(int value){
    setState(() {
      pageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
  return Scaffold(
    body: ListPage[pageIndex],
    bottomNavigationBar: Container(
      width: double.infinity,
      height: 60,
      color: Colors.blue,
      child: BottomNavigationBar(
        enableFeedback: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        onTap: updateIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: pageIndex == 0
                ? Icon(Iconsax.home_15)
                : Icon(Iconsax.home_1),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: pageIndex == 1
                  ? Icon(Iconsax.add5)
                  : Icon(Iconsax.add),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: pageIndex == 2
                  ? Icon(Iconsax.profile_circle5)
                  : Icon(Iconsax.profile_circle),
              label: "Home"
          ),
        ],
      ),
    ),
  );
  }
}
