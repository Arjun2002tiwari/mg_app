// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Auth.dart';
import 'Chatroom.dart';
import 'Database.dart';
import 'Signin.dart';
import 'constant.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _email = TextEditingController();
  Auth authMethods = new Auth();
  DataBaseMethods databaseMethods = new DataBaseMethods();
  var _name = null;
  var _emailId = null;
  var _pass = null;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bumbble',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 125, 7, 146),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                  backgroundColor: Colors.amber, color: Colors.blue[900]))
          : Padding(
              padding: EdgeInsets.all(10),
              child: ListView(children: [
                Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK1kkljo0yMuOPzYDhUHBBvZCIoJKA3nf7RA&usqp=CAU',
                  width: 100,
                  height: 150,
                ),
                Center(
                  child: Text(
                    'Stay Connected!',
                    style: TextStyle(
                        fontSize: 30, color: Color.fromARGB(255, 162, 46, 11)),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _username,
                  decoration: InputDecoration(
                    errorText: _name == null ? null : _name,
                    hintText: 'name',
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    errorText: _emailId == null ? null : _emailId,
                    hintText: 'email',
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                    errorText: _pass == null ? null : _pass,
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_username.text == '' ||
                        _email.text == '' ||
                        _password.text == '') {
                      if (_username.text == '') {
                        setState(() {
                          _name = 'name is required';
                        });
                      } else if (_email.text == '') {
                        setState(() {
                          _emailId = 'email is required';
                        });
                      } else if (_password.text == '') {
                        setState(() {
                          _pass = 'password is required';
                        });
                      }
                    } else {
                      databaseMethods.uploadUserInfo(
                          _username.text, _email.text);
                      setState(() {
                        _name = null;
                        _emailId = null;
                        _pass = null;
                        isLoading = true;
                      });
                      Loading();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[900],
                    padding: EdgeInsets.all(20),
                    minimumSize: const Size.fromHeight(50),
                    shape: StadiumBorder(
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signin()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: EdgeInsets.all(20),
                    minimumSize: const Size.fromHeight(50),
                    shape: StadiumBorder(
                      side: BorderSide(color: Colors.grey, width: 2),
                    ),
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  ),
                ),
              ]),
            ),
    );
  }

  void Loading() {
    authMethods
        .signupWithEmailAndPassword(_email.text, _password.text)
        .then((val) async {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Chatroom(text: _username.text,email:_email.text)));
      SharedPreferences prefs=await SharedPreferences.getInstance();
      prefs.setString('name', _username.text);
      prefs.setString('email', _email.text);
      Constant.email=prefs.getString('email')!;
      Constant.username=prefs.getString('name')!;
      Constant.email=_email.text;
      Constant.username=_username.text;
    });
  }
}
