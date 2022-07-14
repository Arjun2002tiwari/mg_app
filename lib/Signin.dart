// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'Signup.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child:ListView(
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child:Text('Connect with\nyour Friends!',style: TextStyle(fontSize: 40,color:Color.fromARGB(255, 133, 14, 184)),)
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'username',
                  hintStyle: TextStyle(color: Colors.blue,fontSize: 30,),
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.blue,width: 5),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.blue,width: 5),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.blue,width: 5),
                  ),
                ),
                style: TextStyle(color: Colors.blue,fontSize: 20,),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'password',
                  hintStyle: TextStyle(color: Colors.blue,fontSize: 30,),
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.blue,width: 5),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.blue,width: 5),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.blue,width: 5),
                  ),
                ),
                style: TextStyle(color: Colors.blue,fontSize: 20,),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){}, 
                  child: Text('Forgot Password?',style: TextStyle(fontSize: 20,color: Colors.red),),),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: (){},
              style:ElevatedButton.styleFrom(
                padding:EdgeInsets.all(10),
                shape:StadiumBorder(
                  side: BorderSide(color: Colors.blue,width: 5),
                ),
              ),
              child: Text('Sign In',style: TextStyle(fontSize: 30,color: Colors.white),),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text('or',style: TextStyle(fontSize: 30,color: Colors.black,),
                )
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("New User?",style: TextStyle(fontSize: 20,color: Color.fromRGBO(0, 0, 0, 1),fontWeight:FontWeight.bold),),
                  TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                  }, 
                  child: Text("Create acccount",style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 73, 20, 247)),),),
                ],)
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text('Welcome \n    Back!',style: TextStyle(fontSize: 50,color: Color.fromARGB(255, 224, 149, 9),),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}