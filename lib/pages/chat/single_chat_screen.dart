import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_product/pages/chat/messages.dart';
import 'package:my_product/pages/home_page.dart';



class SingleChatScreen extends StatelessWidget {
  //const SingleChatScreen({Key key}) : super(key: key);

  static const routeName = '/chatScreen';
  final String familyId ;
  final String familyName;
  SingleChatScreen(this.familyId,this.familyName);



  @override
  Widget build(BuildContext context) {

    // final routeArg = ModalRoute
    //     .of(context)
    //     .settings
    //     .arguments as Map<String, Object>;
    // final familyId = routeArg['id'];
    // final familyName = routeArg['name'];


    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          backgroundColor: basicColor,
          toolbarHeight: 80,
          // elevation: 0,
          leading:  IconButton(
            icon: Icon(Icons.arrow_back_ios,color: black,),
            onPressed: () {
              //Navigator.of(context).pop(familyName);
              Get.back();
            },
            color: white,
          ),

          title:
          //Image.asset('images/myLogo.png' ,height: 30),
          Text("$familyName Owner",style: TextStyle(color: black),),
          actions:[
            IconButton(
              onPressed: (){
                //Navigator.of(context).pop(familyId);
                //Get.back();
                Get.off(HomePage());
              },
              icon: Icon(Icons.close,color: black,),
            ),
          ]


      ),
      body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Expanded(
                    child: Messages(familyId: familyId)
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: NewMessages(familyId: familyId,store: familyName),
                ),

              ],



            ),
          )
        // StreamBuilder(
        //   stream:
        //   FirebaseFirestore.instance.collection("chats/Qm2EkhbeLycPspcwqXjU/messages").snapshots(),
        //   builder: (context,snapshot) {
        //     if(snapshot.connectionState==ConnectionState.waiting){
        //       return CircularProgressIndicator();
        //     }
        //     else if(!snapshot.hasData){
        //
        //       return CircularProgressIndicator();
        //     }
        //     else {
        //       // has data
        //       final docs = snapshot.data.docs;
        //       return ListView.builder(
        //
        //           itemCount: docs.length,
        //           itemBuilder: (ctx, i) {
        //             return Container(
        //               padding: EdgeInsetsDirectional.only(start: 10,end: 10,top: 15,bottom: 10),
        //               child: Text(docs[i]['text']),
        //
        //             );
        //           }
        //       );
        //     }
        //   }
        // ),


        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   crossAxisAlignment: CrossAxisAlignment.stretch,
        //   children: [
        //     Container(),
        //     Container(
        //       decoration: BoxDecoration(
        //         border: Border(
        //           top: BorderSide(
        //             color: basicColor,
        //             width: 2,
        //
        //           )
        //         )
        //       ),
        //         child: Row(
        //           children: [
        //             Expanded(
        //                 child: TextField(
        //                   onChanged: (value){
        //                    // setState(() {
        //
        //
        //
        //                   },
        //                   decoration: InputDecoration(
        //                     contentPadding: EdgeInsets.symmetric(
        //                       vertical: 10,
        //                       horizontal: 10,
        //                     ),
        //                     hintText: "Start Chatting..",
        //                     border: InputBorder.none,
        //
        //
        //                   ),
        //                 ),
        //             ),
        //             TextButton(
        //                 onPressed: (){
        //                   FirebaseFirestore.instance.collection(
        //                   "chats/Qm2EkhbeLycPspcwqXjU/messages")
        //                       .snapshots().listen((event){
        //                         event.docs.forEach((element) {
        //                           print(element['text']
        //                           );
        //                         });
        //
        //                   });
        //
        //                 },
        //                 child: Text("Send",style: TextStyle(color: black,fontWeight: FontWeight.bold),
        //
        //
        //                 )
        //             )
        //           ],
        //         ),
        //     )
        //   ],
        // ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //
      // ),
    );
  }
}

class NewMessages extends StatefulWidget {
  //const NewMessages({Key key}) : super(key: key);
  @override
  _NewMessagesState createState() => _NewMessagesState();

  String familyId ;
  String store ;
  NewMessages({this.familyId,this.store});
}




class _NewMessagesState extends State<NewMessages> {
  TextEditingController _controller = TextEditingController();
  String _enteredMessage = '';
  final user =  FirebaseAuth.instance.currentUser;
  var docData;
  String username;

  void initState(){
    getUserData();
    super.initState();
  }

  getUserData() async {
    //اجيب بيانات دوكيمنت واحد فقط
    //get will return docs Query snapshot
    await FirebaseFirestore.instance.collection('users').doc(user.uid).get().then((value) async{
      //value.data is the full fields for this doc
      if (value.exists) {
        setState(() {
          docData = value;
          username = docData['username'];
          // print(value.id);
        });
      }});
  }

  _sendMessage()async{
    // تخلي الكيبورد عند الضغط ينزل تحت
    //FocusScope.of(context).unfocus();

    //  ========هنا في النص اللوجيك حق ارسال الرسسالة وخزنها في الفايير ستور========

    // رح ترجع لي دوكيومينت

//مهمممممممممممممممممممممممممممممممممممممممممممممممممممممممم كيف اجيب اليوزر حق الطرف التاني

    // set my chat
    FirebaseFirestore.instance.collection("users").doc(user.uid)
        .collection('chats').doc(widget.familyId).collection('messages')
        .add({
      'text': _enteredMessage,
      'createdAt': DateTime.now(),
      //this is sender data===================
      // 'username': username,//
      'senderId':user.uid,
      'receiverId': widget.familyId,
    }).then((value) {
      print ("message send");
    }).catchError((error){});
    // set the other shat

    FirebaseFirestore.instance.collection("familiesStores").doc(widget.familyId)
        .collection('chats').doc(user.uid).collection('messages')
        .add({
      'text': _enteredMessage,
      'createdAt': DateTime.now(),
      //this is sender data===================
      // 'username': widget.store,//
      'senderId':user.uid,
      'receiverId': widget.familyId,
    });



    //    // .get();
    // FirebaseFirestore.instance.collection("chat")
    //     .add({
    //   'text': _enteredMessage,
    //   'createdAt': Timestamp.now(),
    //   //this is sender data===================
    //   'username': userData['username'],// اقدر اجيب اي حثل في هذا الدوكيمنت
    //     'senderId':user.uid,
    //   'receiverI': widget.receId,
    // });
    //===================================================
    //  وهنا افضي النص عشان ارسل جديد

    _controller.clear();
    setState(() {
      _enteredMessage= '';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child:
              TextField(
                controller: _controller,
                decoration: InputDecoration(hintText: "send a message.."),
                onChanged: (val){
                  setState(() {
                    _enteredMessage = val ;
                    //kjbvjgvjgvjvjh
                  });

                },

              ) ),
          IconButton(

              onPressed: _enteredMessage.trim().isEmpty? null : _sendMessage,
              icon: Icon(Icons.send_outlined))
        ],),);
  }
}

