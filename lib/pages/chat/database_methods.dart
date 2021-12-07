

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{


  createChatRoom(String chatRoomId ,chatRoomInfoMap) async{
    final snapshot = await
    FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(chatRoomId).get();
    if(snapshot.exists){
      // there is this specific chatRoom already exists..
      return true ;

    }else{
      // not exists for this room
     return  FirebaseFirestore.instance.collection('chatRoom')
        .doc(chatRoomId)
        .set(chatRoomInfoMap)
        .catchError((error){
      print("Errorr: $error");
    });
      }
  }

  Future<Stream<QuerySnapshot>> getChatRooms(String myUid)async{

    return FirebaseFirestore.instance
        .collection("chatRoom")
        .orderBy('lastMessageTS',descending: true)
        .where('chatter',arrayContains: myUid).snapshots();

  }


  Future addMessage(String chatRoomId,Map messageInfoMap)async{
    return FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chats')
        //.doc(messageId)
       // .set(messageMap)
    .add(messageInfoMap)
        .catchError((onError){
          print("Error here is $onError");
    });
  }

  updateLastMessageSend(String chatRoomId,Map lastMessageInfoMap){
   return FirebaseFirestore.instance
       .collection('chatRoom').doc(chatRoomId)
        .update(lastMessageInfoMap);
  }


  // Future <Stream<QuerySnapshot>>
  getConversationMessages(String chatRoomId ,String myUid)async{
   // if(chatRoomId.split("_").first== myUid || chatRoomId.split("_").last == myUid) {
      return await FirebaseFirestore.instance
          .collection('chatRoom')
          .doc(chatRoomId)
          .collection('chats')
          .orderBy("DateTime", descending: true)
      // use snapshots() not get() to get data as real time data
          .snapshots();
    //}
   // else{
      //print("nnnnnnnnnnnnnnnnnnnnn");
   // }


  }
  Future <Stream<QuerySnapshot>>getChatRoomMessages(chatRoomId)async{
    return FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chats').orderBy('DateTime',descending: true)
        .snapshots();

  }


}