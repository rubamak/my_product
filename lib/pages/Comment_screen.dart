import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  var CommentsController = TextEditingController()..text = "";

  var firebaseUser = FirebaseAuth.instance.currentUser;

  QuerySnapshot<Map<String, dynamic>> commmentsList;

  Future fetchSpecifiedComment() async {
    try {
      await FirebaseFirestore.instance
          .collection('comments').orderBy('addedAt',descending: true)
          .where('product id', isEqualTo: widget.productId)
          .get()
          .then((specifiedDoc) async {
        if (specifiedDoc != null && specifiedDoc.docs.isEmpty == false) {
          setState(() {
            commmentsList = specifiedDoc;
          });
        } else {
          print('No Docs Found');
        }
      });
    } catch (e) {
      print('Error Fetching Data$e');
    }
  }

  @override
  void initState() {
    fetchSpecifiedComment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (commmentsList != null) {
      return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          toolbarHeight: 70,
          centerTitle: true,

          title: Padding(
            padding: EdgeInsets.only(top: 1),
            child: Text(
              "comments",
              style: TextStyle(color: black, fontSize: 25),
            ),
          ),
          backgroundColor: basicColor,
        ),
        body: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: MediaQuery.of(context).size.height - 100,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(120),
                    )),
                child: ListView.separated(
                    itemBuilder: (context, i) {
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              commmentsList.docs[i]
                                      .data()['Comment']
                                      .toString() ??
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
                        ),
                      );
                    },
                    separatorBuilder: (context, i) => Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            height: 3,
                            color: basicColor,
                          ),
                        ),
                    itemCount: commmentsList.docs.length),
                //it was here
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: CommentsController,
                      decoration:
                          InputDecoration(hintText: "write your comment"),
                    ),
                    IconButton(
                        onPressed: () {
                          addComments();
                          setState(() {
                            addComments();
                          });
                        },
                        icon: Icon(Icons.send_outlined)),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            iconTheme: IconThemeData(color: black),
            toolbarHeight: 100,
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: black),
            ),
            title: Padding(
              padding: EdgeInsets.only(top: 1),
              child: Text(
                "Add comment",
                style: TextStyle(color: black, fontSize: 25),
              ),
            ),
            backgroundColor: basicColor,
          ),
          body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("No Comments"),
            SizedBox(
              height: 100,
            ),
            TextField(
              controller: CommentsController,
              decoration: InputDecoration(hintText: "write your comment"),
            ),
            IconButton(
                onPressed: () {
                  addComments();
                  setState(() {
                  });
                },
                // onPressed:(){ addComments();},
                icon: Icon(Icons.send_outlined)),
            SizedBox(height: 15),
          ]));
    }
  }

  Future addComments() async {
    FocusScope.of(context).unfocus();
    var commentRef = await FirebaseFirestore.instance.collection('comments');
    if (CommentsController.text != ""){
    try {
      commentRef.add({
        'uid': firebaseUser.uid,
        'product id': widget.productId,
        'Comment': CommentsController.text,
        'addedAt': Timestamp.now(),
      }).then((value) {
        print('comment added');
        Fluttertoast.showToast(
          msg: 'comment added',
        );
        Get.back();
        //Navigator.of(context).pop();
      });
    } catch (e) {
      print("error when adding comment: $e");
    }
  }
  else{
    Fluttertoast.showToast(msg:'add comment please');
  }
}}
