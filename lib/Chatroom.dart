// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mg_app/Auth.dart';
import 'package:mg_app/Signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MessageScreen.dart';
import 'Search.dart';
import 'Signup.dart';
import 'constant.dart';

class Chatroom extends StatefulWidget {
  String text;
  String email;
  Chatroom({Key? key, required this.text, required this.email})
      : super(key: key);
  @override
  State<Chatroom> createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  Auth _auth = Auth();
  getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Constant.email = prefs.getString('email')!;
    Constant.username = prefs.getString('name')!;
  }

  @override
  Widget build(BuildContext context) {
    getEmail();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Bumbble', style: TextStyle(fontSize: 30)),
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Drawer(
          backgroundColor: Color.fromARGB(255, 19, 19, 19),
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 213, 122, 117),
                ),
                accountName: Text(widget.text),
                accountEmail: Text(widget.email),
                currentAccountPicture: InkWell(
                  onTap: () {},
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/boy1.jpg"),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.security,
                  color: Colors.white,
                ),
                title: const Text(
                  'Account ',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text('Security notificatuins change number',
                    style:
                        TextStyle(color: Color.fromARGB(255, 181, 154, 154))),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.privacy_tip,
                  color: Colors.white,
                ),
                title: const Text('Privacy ',
                    style: TextStyle(color: Colors.white)),
                subtitle: Text("Block contacts disappearing messages",
                    style:
                        TextStyle(color: Color.fromARGB(255, 181, 154, 154))),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.chat,
                  color: Colors.white,
                ),
                title: const Text(' Chats ',
                    style: TextStyle(color: Colors.white)),
                subtitle: Text("Theme,Wallpapers,chat history",
                    style:
                        TextStyle(color: Color.fromARGB(255, 181, 154, 154))),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.notification_add,
                  color: Colors.white,
                ),
                title: const Text(' Notifications ',
                    style: TextStyle(color: Colors.white)),
                subtitle: Text(
                  "Message,group  & call tones",
                  style: TextStyle(color: Color.fromARGB(255, 181, 154, 154)),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.language,
                  color: Colors.white,
                ),
                title: const Text(' App language ',
                    style: TextStyle(color: Colors.white)),
                subtitle: Text(
                  "English",
                  style: TextStyle(color: Color.fromARGB(255, 181, 154, 154)),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.language,
                  color: Colors.white,
                ),
                title:
                    const Text(' Help ', style: TextStyle(color: Colors.white)),
                subtitle: Text(
                  "Help center,contact us,privacy policy",
                  style: TextStyle(color: Color.fromARGB(255, 181, 154, 154)),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title: const Text(
                  'LogOut',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  _auth.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Signin()));
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: ShowFriends(),
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
      stream: FirebaseFirestore.instance
          .collection('friends')
          .doc(Constant.username)
          .collection('chats')
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
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/back2.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListTile(
                  // shape:RoundedRectangleBorder(
                  //   side:BorderSide(color: Colors.grey.shade500,width:2),
                  // ),
                  tileColor: Colors.grey[400],
                  title: Text(
                    x['username'],
                    style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 249, 247, 247)),
                  ),
                  subtitle: Text(x['email'],
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 255, 254, 254))),
                  leading: Container(
                    child: Stack(children: [
                      CircleAvatar(
                        radius: 23,
                        child: Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 37, 36, 36),
                        ),
                        backgroundColor: Color.fromARGB(255, 219, 212, 210),
                      ),
                    ]),
                  ),
                  trailing: Icon(Icons.message,
                      color: Color.fromARGB(255, 248, 241, 241), size: 40),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MessageScreen(
                                  username: x['username'],
                                  email: x['email'],
                                )));
                  },
                ),
              );
            });
      },
    );
  }
}
