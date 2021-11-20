// ملف يحتوي على كل مسج في الفايبر بيس انضافت
//  رح اعرضها من هنا

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'conversation_screen.dart';

class Messages extends StatelessWidget {
 // const Messages({Key key}) : super(key: key);
  String familyId ;
  Messages({this.familyId});
  final user =  FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    // تدفق الرسائل جمعيها من الفايبر بيس (تجيب)
    
    //if(FirebaseFirestore.instance.collection('familiesStore').where('uid',isEqualTo: user.uid).get())
    return StreamBuilder<QuerySnapshot>(
      // listen to messages without update the page=================
        stream:
        //FirebaseFirestore.instance.collection('chat').doc(receId).collection('messages')
        FirebaseFirestore.instance.collection('users')
            .doc(user.uid)
            .collection('chats').doc(familyId).collection('messages')
        //instance.collection("chat")
        .orderBy('createdAt',descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Object>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            // has data

            
            final docs = snapshot.data.docs;
            return ListView.builder(
              reverse: true,
                itemCount: docs.length,
                itemBuilder: (ctx, i) {
                  return
                  //هناااااااااااااااااااا وقففتتتتتتتت صرت ارسل من اليوزر للعائلة بس باقي اعرض
                    MessageBubble(
                     //docs[i]['username'].toString(),
                      docs[i]['text'].toString(),
                      docs[i]['senderId'].toString()== user.uid? true: false,
                      key: ValueKey(docs[i].id),
                   // padding: EdgeInsetsDirectional.only(start: 10, end: 10, top: 15, bottom: 10),
                    //child: Text(docs[i]['text']),
                  );
                }
            );
          }
        }
    );
  }
  }


