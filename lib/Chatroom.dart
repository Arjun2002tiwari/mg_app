// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mg_app/Auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MessageScreen.dart';
import 'Search.dart';
import 'Signup.dart';
import 'constant.dart';


class Chatroom extends StatefulWidget {
 String text;
 String email;
 Chatroom({Key? key, required this.text, required this.email}) : super(key: key);
  @override
  State<Chatroom> createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  Auth _auth = Auth();
  getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Constant.email=prefs.getString('email')!;
    Constant.username=prefs.getString('name')!;
  }
  @override
  Widget build(BuildContext context) {
    getEmail();
    return Scaffold(
      appBar: AppBar(
          title: Text('ChatRoom',
              style: TextStyle(fontSize: 30)),
          actions: [
            IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Signup()));
              },
              padding: EdgeInsets.symmetric(horizontal: 10),
              icon: Icon(Icons.exit_to_app),
            ),
          ]),
          drawer:Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(widget.text), 
                accountEmail: Text(widget.email),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCfSvm57zgbekmSGH1gUtmqhzae0nQEhIJKw&usqp=CAU"),
                ),
              ),
            ],
          ),
      ),
      body:SingleChildScrollView(
       child:Column(
        children:[
          Container(
            child:ShowFriends(),
          ),
        ],
       ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(Constant.email);
          print(Constant.username);
           Navigator.push(
            context, MaterialPageRoute(builder: (context) => Search()));
        },
        child: Icon(Icons.search),
        
        backgroundColor: Colors.amber[700],
      ),
    );
  }
}
class ShowFriends extends StatelessWidget {
  const ShowFriends({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:FirebaseFirestore.instance.collection('friends').doc(Constant.username).collection('chats').snapshots(),
      builder:(context,snapshot){
        if(!snapshot.hasData){  
          return Center(
            child:CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          primary:true,
          itemCount:snapshot.data!.docs.length,
          itemBuilder:(context,index){
          QueryDocumentSnapshot x=snapshot.data!.docs[index];
          return ListTile(
            // shape:RoundedRectangleBorder(
            //   side:BorderSide(color: Colors.grey.shade500,width:2),
            // ),
            tileColor: Colors.grey[400],
            title:Text(x['username'],style: TextStyle(fontSize: 25,color: Colors.black),),
            subtitle: Text(x['email'],style:TextStyle(fontSize:15,color:Colors.black)),
            leading: Icon(Icons.person_add_alt_1_rounded,size:40,color:Colors.blue[700]),
            trailing: Icon(Icons.message,color:Colors.grey[700],size:40),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => MessageScreen(username: x['username'],)
              ));
            },

          );
        });
      },
    );
  }
}
