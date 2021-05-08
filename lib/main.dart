import 'package:flutter/material.dart';
import 'package:store_management/UI/LoginPage.dart';
import 'package:store_management/UI/SignupPage.dart';
import 'package:store_management/UI/Start.dart';

import 'UI/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
          primaryColor: Colors.orange,
        fontFamily: 'jost',
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),

      routes: <String, WidgetBuilder>{
        "Login" : (BuildContext context)=>Login(),
        "SignUp": (BuildContext context)=>SignUp(),
        "Start": (BuildContext context)=>Start(),
      },

    );
  }
}