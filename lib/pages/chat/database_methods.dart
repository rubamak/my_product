

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{


  createChatRoom(String chatRoomId ,chatRoomMap){
    FirebaseFirestore.instance.collection('chatRoom')
        .doc(chatRoomId)
        .set(chatRoomMap).catchError((error){
      print("Errorr: $error");
    });

  }
}