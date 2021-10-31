import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';



class SingleChatScreen extends StatelessWidget {
  const SingleChatScreen({Key key}) : super(key: key);

  static const routeName = '/chatScreen';


  @override
  Widget build(BuildContext context) {

    final routeArg = ModalRoute
        .of(context)
        .settings
        .arguments as Map<String, Object>;
    final familyId = routeArg['id'];
    final familyName = routeArg['name'];


    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: basicColor,
        elevation: 0,
        leading:  IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop(familyName);
          },
          color: white,
        ),

        title:
          //Image.asset('images/myLogo.png' ,height: 30),
              Text("Chat with $familyName Owner",style: TextStyle(color: black),),
        actions:[
        IconButton(
          onPressed: (){
            Navigator.of(context).pop(familyId);

          },
          icon: Icon(Icons.close,),
        ),
    ]


    ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: basicColor,
                    width: 2,

                  )
                )
              ),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          onChanged: (value){
                           // setState(() {



                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            hintText: "Start Chatting..",
                            border: InputBorder.none,


                          ),
                        ),
                    ),
                    TextButton(
                        onPressed: (){

                        },
                        child: Text("Send",style: TextStyle(color: black,fontWeight: FontWeight.bold),


                        )
                    )
                  ],
                ),
            )
          ],
        ),
      ),
    );
  }
}
