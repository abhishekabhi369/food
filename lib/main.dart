import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food/provider/myprovider.dart';
import 'package:food/screens/login.dart';
import 'package:food/screens/welcome_page.dart';
import 'package:food/screens/widget/cart_page.dart';
import 'package:food/screens/widget/food_details.dart';
import 'package:food/screens/widget/home_page.dart';
import 'package:provider/provider.dart';
import 'screens/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyANQhUVu2cyoIe4JyvHD5pSnqVghKQBiqk',
          appId: "1:205057097990:android:ccd1a79dfce3d0be0f5e87",
          messagingSenderId: "205057097990",
          projectId: "mea-canteen"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MyProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MEA CANTEEN',
          // color: Color(0xff3a3e3e),
          theme: ThemeData(
              scaffoldBackgroundColor: Color(0xff2b2b2b),
              appBarTheme: AppBarTheme(
                color: Color(0xff2b2b2b),
              )),
          //      primaryColor: Colors.blue,
          //  accentColor: Colors.blue ,
          //colorScheme:const ColorScheme.dark(background: Colors.blue),
          //      Color myColor = Theme.of(context).colorScheme.secondary;
          //home: LoginPage());
          routes: {
            'login': (context) {
              return LoginPage();
            },
            'signup': (context) {
              return Signup();
            },
            'homepage': (context) {
              return Homepage();
            },
            // 'detailpage': (context) {
            //   return Detailpage(image: image, price: price, name: name)
            // }
          },
          //   ),
          // );
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (index, snapshot) {
              if (snapshot.hasData) {
                return Homepage();
              }
              return LoginPage();
            },
          ),
          //  home: Detailpage()),
        ));

    // home: Signup()));
    //home: Homepage()));

    //       home: Detailpage()));
  }
}
