// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final TextEditingController _username =
      TextEditingController();
   final TextEditingController _email = TextEditingController();
  final TextEditingController _password =
      TextEditingController();
  Auth authMethods = new Auth();
  DataBaseMethods databaseMethods = new DataBaseMethods();
  var _name = null;
  var _emailId = null;
  var _pass = null;
  var _vaid_email=false;
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
      controller: _username,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.account_circle),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "First Name",
        errorText: _name == null ? null : _name,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      )),
                SizedBox(
                  height: 20,
                ),
                 TextField(
        autofocus: false,
        controller: _email,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
           errorText: _emailId == null ? null : _emailId,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
        )),
                SizedBox(
                  height: 20,
                ),
               TextField(
      autofocus: false,
      controller: _password,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "password",
          errorText: _pass == null ? null : _pass,
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
                    _vaid_email=EmailValidator.validate(_email.text);
                    print(_vaid_email);
                    if (_username.text == '' ||
                        _email.text == '' ||
                        _password.text == '') {
                      if (_username.text == '') {
                        Fluttertoast.showToast(
                          msg: "Please enter valid username!",
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 20
                        );
                        setState(() {
                          _name = 'name is required';
                        });
                      } else if (_email.text == '') {
                        Fluttertoast.showToast(
                          msg: "email required!",
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 20
                        );
                        setState(() {
                          _name=null;
                          _emailId = 'email is required';
                        });
                      } else if (_password.text == '') {
                        Fluttertoast.showToast(
                          msg: "Please enter valid password!",
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 20
                        );
                        setState(() {
                          _emailId=null;
                          _pass = 'password is required';
                        });
                      }
                    } 
                    else if(_vaid_email==false){
                       Fluttertoast.showToast(
                          msg: "Please enter valid email!",
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 20
                        );
                        setState(() {
                          _emailId = 'email is required';
                        });
                      }
                      else if(_password.text.length<6){
                         Fluttertoast.showToast(
                          msg: "Please enter valid password!",
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 20
                        );
                        setState(() {
                          _pass = 'password is required';
                        });
                      }else {
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

  void Loading() async{
    var isP=await databaseMethods.checkuser(_username.text);
    if(isP){
      Fluttertoast.showToast(
        msg: "User exist Already!",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20
      );
      print("user already found!");
      setState(() {
        isLoading=false;
      });
    }
    else{
      databaseMethods.uploadUserInfo(
                          _username.text, _email.text);
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
      Constant.email=_email.text;
      Constant.username=_username.text;
      Fluttertoast.showToast(
        msg: "Signed Up successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 10
      );
      !isLoading;
    });
  }
  }
}
