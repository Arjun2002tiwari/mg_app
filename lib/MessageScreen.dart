// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mg_app/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Database.dart';


class MessageScreen extends StatelessWidget {
  String username;
  MessageScreen({Key? key,required this.username}) : super(key: key);
  TextEditingController _msg=new TextEditingController();
  DataBaseMethods databaseMethods=new DataBaseMethods();

  int chatId(String user1,String user2){
    return user1.codeUnits[0]+user2.codeUnits[0];
  }
  
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      appBar:AppBar(
        title:Text(username,style:TextStyle(fontSize:30)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height/1.27,
              width: size.width,
              padding:EdgeInsets.only(top:15),
              child:ShowMessage(username,Constant.username),
            ),
       Container(
        height: size.height/10,
        width: size.width,
        alignment: Alignment.center,
        child:Container(
          height:size.height/12,
          width:size.width/1.1,
          child: Row(
            children: [
              Container(
                height:size.height/15,
                width:size.width/1.3,
                child:TextField(
                  controller:_msg,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(
                      fontSize: 22,
                      color: Colors.grey,
                    ),
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: (){
                  if(_msg.text.isNotEmpty){
                    print(Constant.username);
                    int Id=chatId(Constant.username,username);
                    var id=Id.toString();
                    print(Id);
                    print(id);
                  databaseMethods.uploadMsg(_msg.text.trim(),Constant.email,id);
                  _msg.clear();
                  }
                }, 
                icon: Icon(Icons.send,color:Colors.grey,size:30)
            ),
          ],
          ),
        ),
       ),
        ]),
      ),
    );
  }
}
class ShowMessage extends StatelessWidget {
  String username="";
  String username2="";
  ShowMessage(this.username, this.username2, {Key? key}) : super(key: key);

  String chatId(String user1,String user2){
    return (user1.codeUnits[0]+user2.codeUnits[0]).toString();
  }

  @override
  Widget build(BuildContext context) {
    String Id=chatId(username2,username);
    return StreamBuilder<QuerySnapshot>(
      stream:FirebaseFirestore.instance.collection('messages').doc(Id).collection('chats').orderBy('time').snapshots(),
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
            title:Column(
              crossAxisAlignment:Constant.email==x['userEmail']?CrossAxisAlignment.end:CrossAxisAlignment.start,
              children: [
                Container(
                  padding:EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Constant.email==x['userEmail']?Colors.purple[300]:Colors.amber[300],
                  ),
                  child: Text(x['msg'],style:Constant.email==x['userEmail']?TextStyle(color:Colors.white,fontSize:20):TextStyle(color:Colors.black,fontSize:20)),)
            ],)
          );
        });
      },
    );
  }
}