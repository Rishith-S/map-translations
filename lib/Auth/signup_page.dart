// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_application_1/reusable_widgets/reusable_widget.dart';
// import 'package:flutter_application_1/screens/home_screen.dart';
// import 'package:flutter_application_1/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:price_pred/Auth/reusable_widgets.dart';
// import 'package:price_pred/Auth/utils.dart';

import '../screens/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                "Sign Up",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/abc.jpg'), fit: BoxFit.cover)
                    // gradient: LinearGradient(colors: [
                    //   hexStringToColor("3b93a0"),
                    //   hexStringToColor("3b93a0"),
                    //   hexStringToColor("3b93a0")
                    ),
                // ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      20, MediaQuery.of(context).size.height * 0.25, 20, 0),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField("Enter UserName", Icons.person_outline,
                          false, _userNameTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField("Enter Email Id", Icons.person_outline,
                          false, _emailTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField("Enter Password", Icons.lock_outlined,
                          true, _passwordTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      firebaseUIButton(context, "Sign Up", () async {
                        setState(() {
                          loading = true;
                        });
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text)
                            .then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        }).onError((error, stackTrace) {
                          // print("Error ${error.toString()}");
                        });
                        // print('uid');
                        String uid = FirebaseAuth.instance.currentUser!.uid;
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(uid)
                            .set({
                          'uid': uid,
                          'username': _userNameTextController.text,
                          'email': _emailTextController.text,
                          'password': _passwordTextController.text,
                        });
                      }),
                    ],
                  ),
                ))),
          );
  }
}
