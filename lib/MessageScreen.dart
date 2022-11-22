// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:mg_app/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Database.dart';

class MessageScreen extends StatelessWidget {
  String email, username;
  MessageScreen({Key? key, required this.email, required this.username})
      : super(key: key);
  TextEditingController _msg = new TextEditingController();
  DataBaseMethods databaseMethods = new DataBaseMethods();

  int chatId() {
    String user1=Constant.myMap[Constant.username]!;
    String user2=Constant.myMap[username]!;
    int u1=int.parse(user1.substring(3,7));
    int u2=int.parse(user2.substring(3,7));
    return u1 + u2;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final number=Constant.myMap[username];
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        titleSpacing: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back,
                size: 24,
              ),
              CircleAvatar(
                child: Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 6, 6, 6),
                ),
                radius: 20,
                backgroundColor: Color.fromARGB(255, 244, 229, 229),
              )
            ],
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
          IconButton(onPressed: () async{
            // launch('tel://$number');
            await FlutterPhoneDirectCaller.callNumber(number!);
            

          }, icon: Icon(Icons.call)),
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
        
        
        backgroundColor: Colors.black,
        title: Column(
          children: [
            Text(username, style: TextStyle(fontSize: 30)),
            Text("$number",style: TextStyle(fontSize: 10),)
          ],
        ),
      
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
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
                           prefixIcon: IconButton(
                                      icon: Icon(Icons.emoji_emotions,color: Colors.white,),
                                      onPressed: (){},
                                     ),
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(onPressed: () {
                                          // shareFile();
                                          showModalBottomSheet(
                                              backgroundColor: Colors.transparent,
                                              context: context, builder:(builder)=>bottomsheet());

                                        },

                                            icon: Icon(Icons.attach_file,color: Colors.white,)),
                                        IconButton(onPressed: () {
                                          // shareText();

                                        },
                                            icon: Icon(Icons.camera_alt,color: Colors.white,))
                                      ],
                                    ),
                                    contentPadding: EdgeInsets.all(5),

                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 255, 255, 255)),
                                  borderRadius: BorderRadius.circular(25.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          hintText: 'Type a message...',
                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 245, 242, 242),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          if (_msg.text.isNotEmpty) {
                            print(Constant.username);
                            int id = chatId();
                            var Id=id.toString();
                            print(id);
                            //print(id);
                            databaseMethods.uploadMsg(
                                _msg.text.trim(), Constant.email, Id);
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
   Widget bottomsheet()
  {
    return Container(
      height: 278,
      // width: MediaQuery.of().size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconcreation(Icons.insert_drive_file,Color.fromARGB(255, 59, 145, 231),"Document"),
                  SizedBox(
                    width: 40,
                  ),
                  iconcreation(Icons.camera_alt,Color.fromARGB(255, 238, 73, 73),"Camera"),
                  SizedBox(
                    width: 40,
                  ),
                  iconcreation(Icons.insert_photo,Colors.purple,"Gallery")
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconcreation(Icons.headset,Colors.orange,"Audio"),
                SizedBox(
                  width: 40,
                ),
                iconcreation(Icons.location_pin,Colors.pink,"Location"),
                SizedBox(
                  width: 40,
                ),
                iconcreation(Icons.person,Colors.blue,"Contact")
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget iconcreation(IconData icon,Color color,String text)
  {
    return InkWell(
      onTap: (){},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(icon,size: 29,color: Colors.white,),

          ),
          SizedBox(
            height: 5,
          ),
          Text(text,style: TextStyle(fontSize: 5),),
        ],
      ),
    );
  }
}

class ShowMessage extends StatelessWidget {
  String username = "";
  String username2 = "";
  ShowMessage(this.username, this.username2, {Key? key}) : super(key: key);

  int chatId() {
    String user1=Constant.myMap[username]!;
    String user2=Constant.myMap[username2]!;
    int u1=int.parse(user1.substring(3,7));
    int u2=int.parse(user2.substring(3,7));
    return u1 + u2;
  }

  @override
  Widget build(BuildContext context) {
    int id = chatId();
    var Id=id.toString();
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
