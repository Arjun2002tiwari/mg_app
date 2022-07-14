// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mg_app/Signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Chatroom.dart';
import 'constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email=prefs.getString('email');
  var name=prefs.getString('name');
  
  if(email==null || name==null){
    runApp(MaterialApp(
      home: Signup(),
    ));
  }
  else{
    Constant.username=name;
    Constant.email=email;
    runApp(MaterialApp(  
      home: Chatroom(text: name,email: email),
    ));
  }
}