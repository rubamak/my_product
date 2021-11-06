import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:get/get.dart';

class MyChats extends StatelessWidget {
  const MyChats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            //Navigator.of(context).pop();
            Get.back();
          },
          color: black,
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 1),
          child: Text(
            "My chats",
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
        body: ListView(
            children: <Widget>[
          SizedBox(
          height: 20,
        ),
        Container(
            height: MediaQuery.of(context).size.height - 120,
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  //bottomRight: Radius.circular(90),
                )),
          child: null,

        )

      ])
    );
  }
}
