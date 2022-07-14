import 'package:firebase_auth/firebase_auth.dart';
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
  Future signOut() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('email');
      prefs.remove('name');
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
  
}