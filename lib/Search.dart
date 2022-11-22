// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, unused_field, avoid_print, avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Database.dart';
import 'MessageScreen.dart';
import 'constant.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  DataBaseMethods databaseMethods=new DataBaseMethods();
  final TextEditingController _search=new TextEditingController();
  bool isLoading=false;
  Map<String,dynamic>? usersMap;
  void onSearch() async {
    FirebaseFirestore _firebase=FirebaseFirestore.instance;
    setState(() {
      isLoading=true;
    });
    await _firebase.collection("users").where("username",isEqualTo: _search.text).get().then((value) {
      setState(() {
        usersMap=value.docs[0].data();
        isLoading=false;
      });
      print(usersMap!.entries.toString());
    });
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Bumbble',
            style: TextStyle(fontSize: 30)),
      ),
      body: isLoading?Center(
          child:CircularProgressIndicator(),
      )
      :Column(
        
        children: [
          Container(
            color: Color.fromARGB(255, 124, 107, 107),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller:_search,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white),
                      border: InputBorder.none
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0x36FFFFFF),
                        const Color(0x0FFFFFFF)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.all(5),
                  child: IconButton(
                    icon: Icon(Icons.search, size: 30, color: Colors.white),
                    onPressed: () {
                      onSearch();
                    },
                  ),
                ),
              ],
            ),
          ),
      
          usersMap!=null?Container(
            
        decoration:BoxDecoration(
          image:DecorationImage(
            image:AssetImage("assets/back2.jpg"),
            fit:BoxFit.cover,
          ),
        ),
            child: ListTile(
              title:Text(usersMap!['username'],style: TextStyle(fontSize: 25,color: Color.fromARGB(255, 248, 243, 243)),),
              subtitle: Text(usersMap!['email'],style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 245, 239, 239)),),
              leading:Container(child: Stack(children: [
                 CircleAvatar(
                  radius: 23,
                  child:Icon(Icons.person,color: Color.fromARGB(255, 16, 16, 16),),
                  backgroundColor: Color.fromARGB(255, 228, 224, 223),
                ),
              ]),),
              // Icon(Icons.person_add_alt_rounded,size: 40,color: Colors.black,),
              trailing: Icon(Icons.message_rounded,size: 50,color: Color.fromARGB(255, 244, 239, 239),),
              onTap: () {
                FirebaseFirestore.instance.collection('friends').doc(Constant.username).collection('chats').add({
                  'email':usersMap!['email'],
                  'username':usersMap!['username'],
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) => MessageScreen(username: usersMap!['username'],email:usersMap!['email'])
                ));
              },
              ),
          ):Container(),  
        ],
      ),
    );
  }
}
