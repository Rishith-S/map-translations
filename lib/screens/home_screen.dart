// ignore_for_file: prefer_const_constructors

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_application_1/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:price_pred/screens/previous_posts.dart';
// import 'package:price_pred/auth_methods/auth_methods.dart';
import 'package:price_pred/screens/upload_screen.dart';
import 'package:price_pred/screens/user_screen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(HomeScreen());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int val = 0;
  var navbar = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: Colors.white,
        ),
        label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.menu, color: Colors.white), label: 'Previous Posts'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.person, color: Colors.white), label: 'User'),
  ];
  var navbody = [
    const Upload(),
    const Displayposts(),
    const User()
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // int val = 0;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const SignInScreen(),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: navbody[val],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: val,
          type: BottomNavigationBarType.fixed, // Fixed
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color.fromARGB(255, 188, 220, 247),
          selectedFontSize: 15,
          unselectedFontSize: 13,
          // fixedColor: Colors.black,
          items: navbar,
          onTap: (value) {
            setState(() {
              val = value;
            });
          },
        ),
      ),
    );
  }
}
