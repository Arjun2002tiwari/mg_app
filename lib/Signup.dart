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
  final TextEditingController nameEditingController =
      TextEditingController();
   final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
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
        centerTitle: true,
        title: Text(
          'Bumbble',
          style: TextStyle(
            color: Color.fromARGB(255, 181, 102, 102),
            fontSize: 30,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 242, 153, 43),
      ),
      body:Container(
         height:double.infinity,
        width:double.infinity,
        decoration:BoxDecoration(
          image:DecorationImage(
            image:AssetImage("assets/back3.jpg"),
            fit:BoxFit.cover,
          ),
        ),
        child:Padding(
              padding: EdgeInsets.all(10),
              child: ListView(children: [
                
                Center(
                  child: Image(image: AssetImage("assets/stay.png"),width: 300,height: 300,)
                ),
                SizedBox(height: 10),
                TextField(
      autofocus: false,
      controller: nameEditingController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.account_circle),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "First Name",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      )),
                SizedBox(
                  height: 20,
                ),
                 TextField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
        )),
                SizedBox(
                  height: 20,
                ),
               TextField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
                SizedBox(
                  height: 20,
                ),
               Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: const Color.fromARGB(255, 5, 5, 5),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: ()  {
                    if (nameEditingController.text == '' ||
                        emailEditingController.text == '' ||
                        passwordEditingController.text == '') {
                      if (nameEditingController.text == '') {
                        setState(() {
                          _name = 'name is required';
                        });
                      } else if (emailEditingController.text == '') {
                        setState(() {
                          _emailId = 'email is required';
                        });
                      } else if (passwordEditingController.text == '') {
                        setState(() {
                          _pass = 'password is required';
                        });
                      }
                    } else {
                      databaseMethods.uploadUserInfo(
                          nameEditingController.text, emailEditingController.text);
                      setState(() {
                        _name = null;
                        _emailId = null;
                        _pass = null;
                        isLoading = true;
                      });
                      Loading();
                    }
                  },
        child: const Text(
          "Sign Up",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
                SizedBox(
                  height: 20,
                ),
                Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: const Color.fromARGB(255, 5, 5, 5),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signin()));
        },
        child: const Text(
          "Sign In",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
              ]),
            ),
    ));
  }

  void Loading() {
    authMethods
        .signupWithEmailAndPassword(emailEditingController.text, passwordEditingController.text)
        .then((val) async {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Chatroom(text: nameEditingController.text,email:emailEditingController.text)));
      SharedPreferences prefs=await SharedPreferences.getInstance();
      prefs.setString('name', nameEditingController.text);
      prefs.setString('email', emailEditingController.text);
      Constant.email=prefs.getString('email')!;
      Constant.username=prefs.getString('name')!;
      Constant.email=emailEditingController.text;
      Constant.username=nameEditingController.text;
    });
  }
}
