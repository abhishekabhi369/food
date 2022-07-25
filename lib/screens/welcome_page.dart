// ignore_for_file: unnecessary_string_escapes, unnecessary_import

import 'dart:ui';

import 'package:flutter/material.dart';

class Welcomepage extends StatelessWidget {
  Widget button({
    required String name,
    required Color color,
  }) {
    return Container(
      height: 55,
      width: 300,
      //     color: color,
      child: ElevatedButton(
        style: ButtonStyle(
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
          name,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {},
      ),
    );
  }

  const Welcomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              //     color: Color.fromARGB(255, 168, 212, 249),
              child: Center(child: Image.asset('images/mealogo.png')),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Welcome to Canteen",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  Column(
                    children: [
                      Text("Something Hot, Something Tasty",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white))
                    ],
                  ),
                  // button(
                  //     name: 'Login', color: Color.fromARGB(255, 242, 242, 242)),
                  Container(
                    height: 55,
                    width: 300,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('login');
                      },
                    ),
                  ),
                  Container(
                    height: 55,
                    width: 300,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        'Signup',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('signup');
                      },
                    ),
                  ),
                  //  button(name: 'Login', color: Colors.white)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
