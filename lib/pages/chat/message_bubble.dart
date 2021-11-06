

import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
class MessageBubble extends StatelessWidget {
MessageBubble(
   this.username,
    this.message,
    this.isMe,
    {this.key});
  final Key key ;
  final String message ;
 final String username;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: !isMe? MainAxisAlignment.end: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe? basicColor: black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
              bottomLeft: isMe? Radius.circular(0): Radius.circular(14),
              bottomRight: isMe? Radius.circular(14): Radius.circular(0),
            )
          ),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
            margin: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
          child: Column(
            crossAxisAlignment: !isMe? CrossAxisAlignment.end: CrossAxisAlignment.start,
            children: [
              Text("$username :",style: TextStyle(
                color: isMe?  black: white,
                fontWeight: FontWeight.bold
              ),) ,
              Text(message,style: TextStyle(color: isMe? black: white,fontSize: 20),textAlign:
                !isMe? TextAlign.end:TextAlign.start ,)
            ],
          ),
        )


    ],);
  }
}
