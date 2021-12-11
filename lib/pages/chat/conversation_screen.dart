import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/pages/chat/database_methods.dart';
import 'package:random_string/random_string.dart';

import 'package:fluttertoast/fluttertoast.dart';


class ConversationScreen extends StatefulWidget {
  // const ConversationScreen({Key key}) : super(key: key);

   final String recevierId;
   String recevierName;
   String chatRoomId= "";

  ConversationScreen({this.recevierId,this.recevierName,this.chatRoomId});

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController messageController = TextEditingController();
  User firebaseUser = FirebaseAuth.instance.currentUser;

  Stream messagesStream;



  //اتوقع مش مهم هادا الاي دي ===========
  String messageId="";
  //String chatRoomId;

  var docData;
  String myName ;
  String myUsername;
  String myEmail ;

  getUserData() async {
    //اجيب بيانات دوكيمنت واحد فقط
    //get will return docs Query snapshot
    await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).get().then((value) async {
      //value.data is the full fields for this doc
      if (value.exists) {
      setState(() {
        docData = value;
        myUsername = docData['username'];
        myName = docData['first name'];
        myEmail = docData['email'];

        // print(value.id);
      });
      } else {}

    });
    widget.chatRoomId =getChatRoomIdByIDs(widget.recevierId,firebaseUser.uid)  ;
  }
  getChatRoomIdByIDs(String user1,String user2){
    if (user1.substring(0, 1).codeUnitAt(0) > user2.substring(0, 1).codeUnitAt(0)) {
    // if(sender.hashCode <= receiver.hashCode) {
    return "$user1\_$user2";
    }else{
    return "$user2\_$user1";
    }

  }
  getAndSetMessages() async{
    messagesStream = await databaseMethods.getChatRoomMessages(widget.chatRoomId);



  }

   doThisNnLaunched()async{
    await getUserData();
    getAndSetMessages();
   }
  @override
  void initState() {
    doThisNnLaunched();

    // databaseMethods.getConversationMessages(widget.chatRoomId, firebaseUser.uid).then((value) {
    //   messagesStream = value;
   //   print("messages in stream ");});
    setState(() {});
    super.initState();
  }

  Widget chatMessagesList() {
    return StreamBuilder(
        stream: messagesStream,
        builder: (context, snapshot) {
          if(snapshot.connectionState ==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (snapshot.hasData) {
            return ListView.builder(
              primary: true,
                reverse: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, i) {
                  DocumentSnapshot snap = snapshot.data.docs[i];
                  return
                    // ListTile(
                    // subtitle: Text(snap['message'].toString() ),
                    // title:  Text(snap['senderId'].toString() == firebaseUser.uid ?
                    // snap['sender'].toString() +":"
                    //     :snap['recevierName'].toString() +":"),
                  MessageBubble(
                      snap['message'].toString(),
                      snap['senderId'].toString() == firebaseUser.uid ? true : false,
                      key: ValueKey(snap.id),
                    recevierName: snap['senderId'].toString() == firebaseUser.uid ?
                    snap['recevierName'].toString():snap['sender'].toString() ,
                  );
                });
          }

          else {
            return Center(
              child: Text("no messages"),
            );
          }
        });
  }

  addMessages() async {
    //FocusScope.of(context).unfocus();
    if (messageController.text.isNotEmpty) {
      String message = messageController.text.trim();
      var lastMessageTs= DateTime.now();

      Map <String, dynamic> messageInfoMap = {
        'message':message,
        'sender': myUsername,
        'senderId': firebaseUser.uid,
        'DateTime': lastMessageTs,

        'recevierId': widget.recevierId,
        'recevierName': widget.recevierName
      };
      // if(messageId == ""){
      //   messageId= randomAlpha(12);}

      databaseMethods.addMessage(widget.chatRoomId,messageInfoMap)
          .then((val){
        Map<String,dynamic> lastMessageInfoMap ={
          "lastMessage": message,
          "lastMessageTS": lastMessageTs,
          "lastMessageSendBy": myUsername,
        };
        databaseMethods.updateLastMessageSend(widget.chatRoomId,lastMessageInfoMap);

      });
      messageController.clear();
    }else{
      Fluttertoast.showToast(msg: "please enter a message",textColor: Colors.red,backgroundColor: basicColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.only(top: 1),
            child: Text(
              widget.recevierName.toString(),
              style: TextStyle(
                color: black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          backgroundColor: basicColor,
          toolbarHeight: 80,
        ),
        backgroundColor: basicColor,
        body: SafeArea(
          child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 130,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    //bottomRight:Radius.circular(150),
                  )),
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 8, top: 18, end: 7),
                        child: chatMessagesList(),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  hintText: "send a message..",
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  addMessages();
                                },
                                //_enteredMessage.trim().isEmpty? null : _sendMessage,
                                icon: Icon(Icons.send_outlined))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}
// تصميم كل حبة مسج
class MessageBubble extends StatelessWidget {
  MessageBubble(

      this.message,
      this.isMe,
      {this.key,this.recevierName}
  );

  final Key key;
  final String message;
  final String recevierName;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
         // width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: isMe
                      ? [Colors.blueGrey, basicColor, grey,]
                      : [Colors.deepOrangeAccent, Colors.blueGrey,black]),
              // color: isMe? basicColor: black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: isMe ? Radius.circular(20) : Radius.circular(0),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(20),
              )),
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              isMe
                  ? Text(
                      "Me:",
                      style: TextStyle(color: black, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      recevierName,
                      style: TextStyle(color: white, fontWeight: FontWeight.bold),
                    ),
              Text(
                message,
                softWrap: true,
                maxLines: 1,
                style: TextStyle(color: isMe ? black : white, fontSize: 17),
                textAlign: !isMe ? TextAlign.end : TextAlign.start,
              )
            ],
          ),
        )
      ],
    );
  }
}
