// ignore_for_file: avoid_print, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods{

  uploadUserInfo(String username,String email) async {
     await FirebaseFirestore.instance.collection('users').doc(username).set({
      'username': username,
      'email': email,
    });
  }
  uploadMsg(String msg,String userEmail,String chatroomId) async {
    FirebaseFirestore.instance.collection('messages').doc(chatroomId).collection('chats').add({
      'msg': msg,
      'userEmail': userEmail,
      'time': FieldValue.serverTimestamp(),
    });
  }
}