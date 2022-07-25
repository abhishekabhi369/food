import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food/models/categories.dart';
import 'package:food/models/food_modle.dart';
import 'package:food/provider/myprovider.dart';
import 'package:food/screens/widget/food_details.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<CategoriesModel> sadyaList = [];

  List<FoodModle> singleFoodList = [];

  FirebaseAuth auth = FirebaseAuth.instance;

  signOut() async {
    await auth.signOut();
  }

  Widget categories({required String image, required String name}) {
    return Column(
      children: [
        GestureDetector(
          child: Container(
            margin: EdgeInsets.only(left: 20),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.fill),
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
        SizedBox(
          height: 10,
          width: 5,
        ),
        Text(name,
            style: TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        SizedBox(
          height: 10,
          width: 5,
        ),
      ],
    );
  }

  Widget bottomview(
      {required String image,
      required String name,
      required int price,
      required Function onTap}) {
    return GestureDetector(
      onTap: onTap(),
      child: Container(
        height: 270,
        width: 220,
        decoration: BoxDecoration(
            color: Color(0xff3a3e3e), borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(image),
            ),
            ListTile(
              leading: Text(name,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  )),
              trailing: Text(
                "\$ $price",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 20,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 20,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 20,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 20,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawer({required String name, required IconData icon}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        name,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  Widget sadya() {
    return Row(
      children: sadyaList
          .map((e) => categories(image: e.image, name: e.name))
          .toList(),
    );
  }

  Widget foods() {
    return Column(
        children: singleFoodList
            .map((e) => bottomview(
                image: e.image,
                name: e.name,
                price: e.price,
                onTap: () {
                  //    Navigator.of(context).pushNamed('detailpage');
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Detailpage(
                        image: e.image, price: e.price, name: e.name);
                  }));
                }))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);

    provider.getcategories();
    sadyaList = provider.throwlist;

    provider.getfoodlist();
    singleFoodList = provider.throwFoodModleList;
    //void initState() {
    //singleFoodList = provider.throwFoodModleList;
    //super.initState();
    //}

    return Scaffold(
        drawer: Drawer(
          child: Container(
            color: Colors.black,
            child: SafeArea(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/Dark.jpeg'))),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage('images/dosa.jpg'),
                    ),
                    accountName: Text('ABHISHEK'),
                    accountEmail: Text("Abhishekabhi@gmail.com")),
                drawer(name: 'Profile', icon: Icons.person),
                drawer(name: 'Cart', icon: Icons.add_shopping_cart),
                drawer(name: 'Order', icon: Icons.shop),
                Divider(
                  thickness: 2,
                  color: Colors.white,
                ),
                TextButton(
                    onPressed: () {
                      signOut();
                      Navigator.of(context).pop();
                      // Navigator.of(context).pushNamed('welcomepage');
                    },
                    child: drawer(name: 'Logout', icon: Icons.logout)),
              ],
            )),
          ),
        ),
        appBar: AppBar(
          elevation: 0.0,
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(Icons.sort),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
          actions: [
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: CircleAvatar(
                //   backgroundColor: Colors.green,
                backgroundImage: AssetImage("assets/images/profile.jpg"),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: "What Do You Want",
                  hintStyle:
                      TextStyle(color: Color.fromARGB(75, 197, 178, 178)),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  filled: true,
                  fillColor: Color(0xff3a3e3e),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              //    physics: ScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  sadya(),
                  //categories(
                  // image: 'assets/images/appam.jpeg',
                  //  name: "Appam",
                  //),
                  //onTap: () {}),
                  // categories(
                  //  image: 'assets/images/chickencurry.png',
                  //  name: "Chicken Curry",
                  // ),
                  // ontap: () {},
                  // categories(
                  //  image: 'assets/images/BeefFry.jpg',
                  //  name: "Beef Fry",
                  // ),
                  //ontap: () {}),
                  // categories(
                  //  image: 'assets/images/biri.png',
                  //   name: "Biriyani",
                  // ),
                  // //ontap: () {}),
                  // categories(
                  //  image: 'assets/images/sadya.jpg',
                  //  name: "Sadya",
                  // ),
                  //ontap: () {}),
                ],
              ),
            ),
            GestureDetector(
              child: Expanded(
                  child: GridView.count(
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: singleFoodList
                          .map((e) => bottomview(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return Detailpage(
                                        image: e.image,
                                        price: e.price,
                                        name: e.name);
                                  }));
                                  //  Navigator.of(context).pushNamed('detailpage');
                                },
                                image: e.image,
                                price: e.price,
                                name: e.name,
                              ))
                          .toList())),
            )
            //children: [
            //bottomview(
            //   image: 'assets/images/biriyani.jpg',
            //   price: 25,
            //  name: 'biriyani'),
            //bottomview(
            //   image: 'assets/images/sadya.jpg',
            //    price: 25,
            //   name: 'Sadya'),
            //bottomview(
            //image: 'assets/images/dosa.jpg', price: 25, name: 'Dosa'),
            //bottomview(
            //  image: 'assets/images/beefcurry.jpeg',
            //price: 25,
            //name: 'Beef')
            //],
          ],
        ));
  }
}
