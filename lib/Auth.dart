import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signupWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      print(user?.uid);
      
      return user;
    } catch (e) {
      print(e.toString());
    }
  }
static Future<User?> signInUsingEmailPassword({
  required String email,
  required String password,
  //required BuildContext context,
}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
       Fluttertoast.showToast(
                     msg: "User not found!!",
                     backgroundColor: Colors.red,
                     textColor: Colors.white,
                     fontSize: 15
                   );
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided.');
      Fluttertoast.showToast(
                     msg: "Invalid Password!",
                     backgroundColor: Colors.red,
                     textColor: Colors.white,
                     fontSize: 15
                   );

    }
  }

  return user;
}

  Future signOut() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('email');
      //prefs.remove('name');
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
  
}