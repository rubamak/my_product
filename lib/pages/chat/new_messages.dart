//  ملف يحتوي على الفيلد الخاص لليوزر بكتابة الرسالة

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// class NewMessages extends StatefulWidget {
//   const NewMessages({Key key}) : super(key: key);
//   @override
//   _NewMessagesState createState() => _NewMessagesState();
// }
//
//
//
//
// class _NewMessagesState extends State<NewMessages> {
//   TextEditingController _controller = TextEditingController();
//   var _enteredMessage = '';
//
//   _sendMessage(){
//     // تخلي الكيبورد عند الضغط ينزل تحت
//     //FocusScope.of(context).unfocus();
//     //  هنا في النص اللوجيك حق ارسال الرسسالة وخزنها في الفايير ستور
//
//       FirebaseFirestore.instance.collection("chat")
//           .add({
//         'text': _enteredMessage,
//         'createdAt': Timestamp.now(),
//       });
//     //  وهنا افضي النص عشان ارسل جديد
//
//     _controller.clear();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top:8),
//       padding: EdgeInsets.all(8),
//       child: Row(
//         children: [
//       Expanded(
//           child:
//           TextField(
//             controller: _controller,
//             decoration: InputDecoration(hintText: "send a message.."),
//             onChanged: (val){
//               setState(() {
//                _enteredMessage = val ;
//               });
//
//             },
//
//           ) ),
//       IconButton(
//
//           onPressed: _enteredMessage.trim().isEmpty? null : _sendMessage,
//           icon: Icon(Icons.send_outlined))
//     ],),);
//   }
// }
