import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food/screens/widget/textfield.dart';

class Signup extends StatefulWidget {
  static String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool loading = false;
  late UserCredential userCredential;
  RegExp regxp = RegExp(Signup.pattern);
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confirm = TextEditingController();
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  Future sendData(BuildContext ctx) async {
    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: pass.text,
      );

      await FirebaseFirestore.instance
          .collection('userData')
          .doc(userCredential.user?.uid)
          .set({
        'name': name.text,
        'email': email.text,
        'userid': userCredential.user?.uid,
        'pass': pass.text,
        'confirm': confirm.text,
      });

      showDialog(
          context: ctx,
          builder: (ctx1) {
            return AlertDialog(
              title: Text("Account Created SuccessFully"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('login');
                    },
                    child: Text("Go to Login Page"))
              ],
            );
          });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // globalKey.currentState.showSnackBar(
        //   SnackBar(
        //     content: Text("The password provided is too weak."),
        //   ),
        // );
        ScaffoldMessenger.of(ctx).showSnackBar(
            SnackBar(content: Text('The Password providede is weak')));
      } else if (e.code == 'email-already-in-use') {
        // ignore: deprecated_member_use
        // globalKey.currentState.showSnackBar(
        //   SnackBar(
        //     content: Text("The account already exists for that email"),
        //   ),
        // );

        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
            content: Text('The account already exists for that email')));
      }
    } catch (e) {
      // globalKey.currentState.showSnackBar(
      //   SnackBar(
      //     content: Text(e),
      //   ),
      // );

      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text('Error')));
      setState(() {
        loading = false;
      });
    }
    setState(() {
      loading = false;
    });
  }

  //var phone = int.parse(mobile);

  void validation(BuildContext ctx) {
    if (name.text.trim().isEmpty ||
        email.text.trim().isEmpty ||
        mobile.text.trim().isEmpty ||
        pass.text.trim().isEmpty ||
        confirm.text.trim() == null) {
      //globalKey.currentState.
      final _errormsg = 'Enter all the details to Login';

      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text(_errormsg)));
      return;
    }
    if (pass.text.trim() != confirm.text.trim()) {
      final _errormsg = 'Incorrect Password';

      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text(_errormsg)));
      return;
    }
    // ignore: non_constant_identifier_names
    else if (!regxp.hasMatch(email.text)) {
      final _errormsg = 'Enter Valid Email';

      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text(_errormsg)));
      return;
    }
    //   if(mobile.text != ){}

    else if (mobile.text.length != 10) {
      final _errormsg = 'Enter Valid Phone number';

      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text(_errormsg)));
      return;
    }
    // else if {
    //   sendData(ctx);
    // }

    else {
      setState(() {
        loading = true;
      });
      sendData(ctx);
    }
  }

  Widget textfield({
    required String hinttext,
  }) {
    return TextFormField(
        //obscureText: false,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: hinttext,
            hintStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              color: Colors.grey,
            ))));
  }

  Widget Button(
      {required String buttonname,
      required Color c1,
      required Color textcolor}) {
    return Container(
      width: 120,
      //  color: Colors.grey,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(c1),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
            ),
          ),
        ),
        child: Text(
          buttonname,
          style: TextStyle(
              color: textcolor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          validation(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "SignUp",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              Container(
                height: 300,
                child: Column(
                  children: [
                    //      textfield(hinttext: "Name"),

                    MyTextField(
                        hintText: "Enter Your Name",
                        obscureText: false,
                        controller: name),
                    MyTextField(
                        hintText: 'Email',
                        obscureText: false,
                        controller: email)
                    // textfield(hinttext: "Email"),

                    ,
                    MyTextField(
                        hintText: "Enter Your Mobile",
                        obscureText: false,
                        controller: mobile),

                    MyTextField(
                        hintText: "Enter The Password",
                        obscureText: true,
                        controller: pass),

                    MyTextField(
                        hintText: "Confirm Password",
                        obscureText: true,
                        controller: confirm),
                    // textfield(hinttext: "Mobile Number"),
                    // textfield(hinttext: "Password"),
                    // textfield(hinttext: "Confirm Password")
                  ],
                ),
              ),
              loading
                  ? CircularProgressIndicator()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Button(
                        //     buttonname: 'Cancel',
                        //     c1: Colors.white,
                        //     textcolor: Colors.black),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Button(
                            buttonname: 'Register',
                            c1: Colors.white,
                            textcolor: Color.fromARGB(255, 18, 18, 18))
                        // ElevatedButton(
                        //   style: ButtonStyle(
                        //     backgroundColor: MaterialStateProperty.all(
                        //         Color.fromARGB(255, 180, 255, 114)),
                        //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        //       RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(18.0),
                        //         side: BorderSide(
                        //           color: Colors.white,
                        //           width: 2.0,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        //   child: Text(
                        //     "SignUp",
                        //     style: TextStyle(
                        //         color: Color.fromARGB(255, 48, 48, 48), fontSize: 20),
                        //   ),
                        //   onPressed: () {},
                        // )
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
