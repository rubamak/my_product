import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:my_product/color/my_colors.dart';

class CommentsPage extends StatefulWidget {
  @override
  State<CommentsPage> createState() => CommentPageState();
  var productId;

  CommentsPage({this.productId});
}

class CommentPageState extends State<CommentsPage> {
  TextEditingController CommentsController = TextEditingController();

  User firebaseUser = FirebaseAuth.instance.currentUser;

  QuerySnapshot<Map<String, dynamic>> commmentsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: basicColor,
          iconTheme: IconThemeData(color: black),
          toolbarHeight: 100,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: black),
            onPressed: () {
              Get.back();
            },
            color: black,
          ),
          title: Padding(
            padding: EdgeInsets.only(top: 1),
            child: Text(
              "comments page",
              style: TextStyle(color: black, fontSize: 25),
            ),
          ),
        ),
        body: Column(children: [
          Expanded(
              child: Container(
            height: MediaQuery.of(context).size.height - 100,
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(120),
                )),
          child:ListView.separated(
          itemBuilder: (context, i) {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(commmentsList.docs[i].data()['Comment'].toString() ??
                          "none",
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            color: black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
    },

              )
              )
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: TextField(
              controller: CommentsController,
              decoration:
              InputDecoration(
                  hintText: "write your comment",
                   hintStyle: TextStyle(
                     color: grey,
                   )),
            ),
          )
        ]));
  }
}
