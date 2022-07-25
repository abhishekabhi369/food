import 'package:flutter/material.dart';

class Mycart extends StatelessWidget {
  const Mycart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          height: 65,
          margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Color(0xff3a3e3e),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$23",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Text(
                "Checkout",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Column(
          children: [
            Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 170,
                  height: 170,
                  // color: Colors.white,
                  child: CircleAvatar(
                    // backgroundColor: Colors.orange,
                    backgroundImage: AssetImage('assets/images/biriyani.jpg'),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: 200,
                      //       color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "FoodName",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "food good",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "\$30",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.remove_circle_outline),
                                color: Colors.white,
                                iconSize: 40,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '1',
                                style: TextStyle(color: Colors.white),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.add_circle_outline),
                                color: Colors.white,
                                iconSize: 40,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.close),
                      color: Colors.white,
                    )
                  ],
                ))
              ],
            )
          ],
        ));
  }
}
