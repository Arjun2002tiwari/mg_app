// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mg_app/Signin.dart';
import 'package:mg_app/Signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Chatroom.dart';
import 'constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  FlutterNativeSplash.removeAfter(initialization);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  var name = prefs.getString('name');
  if (email == null || name == null) {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // fontFamily: "sono",
        //fontFamily: "RubikMoonrocks",
      
        // scaffoldBackgroundColor: const Color.fromARGB(255, 113, 95, 95),
        primarySwatch: Colors.red,
      ),
      home: Signin(),
    ));
    
  } else {
    Constant.username = name;
    Constant.email = email;
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Chatroom(text: name, email: email),
    ));
  }
  
}
 Future initialization(BuildContext context) async{
      await Future.delayed(Duration(seconds: 2));
    }
