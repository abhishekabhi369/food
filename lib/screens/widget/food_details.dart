import 'dart:ui';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class Detailpage extends StatelessWidget {
  Detailpage({required this.image, required this.price, required this.name});
  final String image;
  final int price;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                  child: CircleAvatar(
                      radius: 110,
                      backgroundImage:
                          // AssetImage('assets/images/BeefFry.jpg'))),
                          NetworkImage(image))),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xff3a3e3e),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text("Any Text",
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Icon(Icons.remove)),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "1",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Icon(Icons.add))
                            ],
                          ),
                          Text(
                            "\$$price",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "foehfuehgiudshgiudrfhgoirhgeoroigjhworigjwoeifjweoifjwe9fjwoekfnwoeiefjwqoidfheriufhwoidnwiufhwaqsjdbswidjfbasijcfbnasifhasiufddhnh",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Container(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.black))),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xff3a3e3e))),
                          onPressed: () {},
                          child: Text(
                            "Add to cart",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ));
  }
}
