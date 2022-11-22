// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mg_app/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Database.dart';

class MessageScreen extends StatelessWidget {
<<<<<<< HEAD
  String username;
  MessageScreen({Key? key, required this.username}) : super(key: key);
  TextEditingController _msg = new TextEditingController();
  DataBaseMethods databaseMethods = new DataBaseMethods();

  int chatId(String user1, String user2) {
    return user1.codeUnits[0] + user2.codeUnits[0];
=======
  String email,username;
  MessageScreen({Key? key,required this.email,required this.username}) : super(key: key);
  TextEditingController _msg=new TextEditingController();
  DataBaseMethods databaseMethods=new DataBaseMethods();

  String chatId(String user1,String user2){
    return user1+user2;
>>>>>>> 7bfac90f3fe7ff0a943f7713dc4c469e5f37f90a
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
<<<<<<< HEAD
      appBar: AppBar(
        backgroundColor: Colors.black,
        leadingWidth: 70,
        titleSpacing: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
=======
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
              child:ShowMessage(email,Constant.email),
            ),
       Container(
        height: size.height/10,
        width: size.width,
        alignment: Alignment.center,
        child:Container(
          height:size.height/12,
          width:size.width/1.1,
>>>>>>> 7bfac90f3fe7ff0a943f7713dc4c469e5f37f90a
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back,
                size: 24,
              ),
<<<<<<< HEAD
              CircleAvatar(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                radius: 20,
                backgroundColor: Color.fromARGB(255, 102, 75, 75),
              )
            ],
=======
              IconButton(
                onPressed: (){
                  if(_msg.text.isNotEmpty){
                    print(Constant.username);
                    String id=chatId(Constant.email,email);
                    //var id=Id.toString();
                    print(id);
                    //print(id);
                  databaseMethods.uploadMsg(_msg.text.trim(),Constant.email,id);
                  _msg.clear();
                  }
                }, 
                icon: Icon(Icons.send,color:Colors.grey,size:30)
            ),
          ],
>>>>>>> 7bfac90f3fe7ff0a943f7713dc4c469e5f37f90a
          ),
        ),
        title: Text(username, style: TextStyle(fontSize: 30)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
          IconButton(onPressed: () {}, icon: Icon(Icons.call)),
          PopupMenuButton(itemBuilder: (BuildContext contesxt) {
            return [
              PopupMenuItem(child: Text("View Contect"), value: "View Contect"),
              PopupMenuItem(
                  child: Text("Media, links, and docs"),
                  value: "Media, links, and docs"),
              PopupMenuItem(
                  child: Text("Chatting app Web"), value: "Chatting app Web"),
              PopupMenuItem(child: Text("Search"), value: "Search"),
              PopupMenuItem(
                  child: Text("Mute Notifications"),
                  value: "Mute Notifications"),
              PopupMenuItem(child: Text("wallpaper"), value: "wallpaper"),
              PopupMenuItem(child: Text("More..."), value: "More...")
            ];
          })
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/back2.jpg"),
          fit: BoxFit.cover,
        )),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: size.height / 1.27,
              width: size.width,
              padding: EdgeInsets.only(top: 15),
              child: ShowMessage(username, Constant.username),
            ),
            Container(
              height: size.height / 10,
              width: size.width,
              alignment: Alignment.center,
              child: Container(
                height: size.height / 12,
                width: size.width / 1.1,
                child: Row(
                  children: [
                    Container(
                      height: size.height / 15,
                      width: size.width / 1.3,
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: _msg,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.emoji_emotions,
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3,
                                color: Color.fromARGB(255, 254, 255, 255)),
                                borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3,
                                color: Color.fromARGB(255, 254, 253, 251)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        backgroundColor:
                                            Color.fromARGB(0, 240, 238, 238),
                                        context: context,
                                        builder: (builder) => bottomsheet());
                                  },
                                  icon: Icon(
                                    Icons.attach_file,
                                    color: Colors.white,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ))
                            ],
                          ),

                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 252, 250, 250),
                          ),
                          // border:OutlineInputBorder(
                          //   // borderSide:BorderSide(width: 3, color: Color.fromARGB(255, 253, 255, 254)),
                          //   borderRadius: BorderRadius.circular(20),
                          // ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          if (_msg.text.isNotEmpty) {
                            print(Constant.username);
                            int Id = chatId(Constant.username, username);
                            var id = Id.toString();
                            print(Id);
                            print(id);
                            databaseMethods.uploadMsg(
                                _msg.text.trim(), Constant.email, id);
                            _msg.clear();
                          }
                        },
                        icon: Icon(Icons.send, color: Colors.grey, size: 30)),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 278,
      // width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconcreation(
                      Icons.insert_drive_file, Colors.indigo, "Document"),
                  SizedBox(
                    width: 40,
                  ),
                  iconcreation(Icons.camera_alt, Colors.pink, "Camera"),
                  SizedBox(
                    width: 40,
                  ),
                  iconcreation(Icons.insert_photo, Colors.purple, "Gallery")
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconcreation(Icons.headset, Colors.orange, "Audio"),
                SizedBox(
                  width: 40,
                ),
                iconcreation(Icons.location_pin, Colors.pink, "Location"),
                SizedBox(
                  width: 40,
                ),
                iconcreation(Icons.person, Colors.blue, "Contact")
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget iconcreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 5),
          ),
        ],
      ),
    );
  }
}

class ShowMessage extends StatelessWidget {
  String username = "";
  String username2 = "";
  ShowMessage(this.username, this.username2, {Key? key}) : super(key: key);

<<<<<<< HEAD
  String chatId(String user1, String user2) {
    return (user1.codeUnits[0] + user2.codeUnits[0]).toString();
=======
  String chatId(String user1,String user2){
    return user1+user2;
>>>>>>> 7bfac90f3fe7ff0a943f7713dc4c469e5f37f90a
  }

  @override
  Widget build(BuildContext context) {
    String Id = chatId(username2, username);
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('messages')
          .doc(Id)
          .collection('chats')
          .orderBy('time')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
            shrinkWrap: true,
            primary: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              QueryDocumentSnapshot x = snapshot.data!.docs[index];
              return ListTile(
                  title: Column(
                crossAxisAlignment: Constant.email == x['userEmail']
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Constant.email == x['userEmail']
                          ? Colors.purple[300]
                          : Colors.amber[300],
                    ),
                    child: Text(x['msg'],
                        style: Constant.email == x['userEmail']
                            ? TextStyle(color: Colors.white, fontSize: 20)
                            : TextStyle(color: Colors.black, fontSize: 20)),
                  )
                ],
              ));
            });
      },
    );
  }
}
