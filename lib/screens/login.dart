import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food/screens/welcome_page.dart';
import 'package:food/screens/widget/textfield.dart';

class LoginPage extends StatefulWidget {
  static String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  // Widget Textfield(
  //     {required String hinttext,
  //     required IconData icon1,
  //     required Color iconscolor}) {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //         //        iconColor: Colors.white,
  //         prefixIcon: Icon(
  //           icon1,
  //           color: iconscolor,
  //         ),
  //         hintText: hinttext,
  //         hintStyle: TextStyle(color: Colors.white),
  //         enabledBorder:
  //             UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
  //   );
  // }

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  RegExp regExp = RegExp(LoginPage.pattern);
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  late UserCredential usercredential;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Future login(BuildContext ctx) async {
    try {
      usercredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(ctx).showSnackBar(
            SnackBar(content: Text('No user found for that email')));
        //   print('No user found for that email.');
        loading = false;
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(ctx).showSnackBar(
            SnackBar(content: Text('Wrong password provided for that user')));
        //   print('Wrong password provided for that user.');
        setState(() {
          loading = false;
        });
      }
      setState(() {
        loading = false;
      });
    }
  }

  void validation(BuildContext ctx) {
    if (email.text.trim().isEmpty ||
        email.text.trim() == null && password.text.trim().isEmpty ||
        password.text.trim() == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('All Field is Empty')));
      return;
    }
    if (email.text.trim().isEmpty || email.text.trim() == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Email is empty')));
      return;
    }
    if (password.text.trim().isEmpty || password.text.trim() == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Password is empty')));
      return;
    } else if (!regExp.hasMatch(email.text)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Enter Valid Email')));
      return;
    } else {
      setState(() {
        loading = true;
      });
      login(context);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 170),
              child: Text(
                "Log In",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(children: [
              MyTextField(
                  hintText: 'Email', obscureText: false, controller: email)

              // Textfield(
              //     hinttext: "Username",
              //     icon1: Icons.person_outline,
              //     iconscolor: Colors.white),
              ,
              SizedBox(
                height: 0,
              ),
              MyTextField(
                  hintText: 'Password', obscureText: true, controller: password)
              // Textfield(
              //     hinttext: "Password",
              //     icon1: Icons.lock,
              //     iconscolor: Colors.white),
            ]),
            loading
                ? CircularProgressIndicator()
                : Container(
                    height: 60,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        validation(context);
                      },
                      child: Text(
                        "LogIn",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('signup');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New User?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "Register Now",
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
