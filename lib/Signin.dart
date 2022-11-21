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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         height:double.infinity,
        width:double.infinity,
        decoration:BoxDecoration(
          image:DecorationImage(
            image:AssetImage("assets/back5.jpg"),
            fit:BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child:ListView(
              children: [
                SizedBox(
                  height: 150,
                ),
                Center(
                  child:Image(image: AssetImage("assets/loginpage.png"),)
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
          autofocus: false,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.mail),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Email",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          )),
                SizedBox(
                  height: 40,
                ),
                TextField(
          autofocus: false,
          controller: passwordController,
          obscureText: true,
         
          keyboardType: TextInputType.visiblePassword,
          
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.vpn_key),
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "password",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){}, 
                    child: Text('Forgot Password?',style: TextStyle(fontSize: 20,color: Colors.black),),),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
               Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Color.fromARGB(255, 16, 15, 15),
        child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            // signIn(emailController.text, passwordController.text);
          },
          child: const Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
    ),
                SizedBox(
                  height: 10,
                ),
                
                SizedBox(
                  height: 5,
                ),
                Center(
                  child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?",style: TextStyle(fontSize: 20),),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                                },
                              child: const Text("Sign Up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color:Color.fromARGB(255, 255, 163, 72),),),
                            )
                          ],
                        )
                ),
                SizedBox(
                  height: 20,
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}