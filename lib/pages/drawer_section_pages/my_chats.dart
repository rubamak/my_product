import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:get/get.dart';
import 'package:my_product/widgets/main_drawer.dart';

class MyChats extends StatefulWidget {
  const MyChats({Key key}) : super(key: key);

  @override
  State<MyChats> createState() => _MyChatsState();
}

class _MyChatsState extends State<MyChats> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  var docData;// for printing
  var username; // for display to user
  var useremail;



  getUserData() async {
    //اجيب بيانات دوكيمنت واحد فقط
    DocumentReference documentReference = FirebaseFirestore.instance.collection(
        'users').doc(firebaseUser.uid);
    //get will return docs Query snapshot
    await documentReference.get().then((value) {
      //value.data is the full fields for this doc
      if (value.exists) {
        setState(() {
          docData = value.data();

          useremail = docData['email'];
          username = docData['username'];

          // print(value.id);
        });
        // print(docData['uid']);
        // print(docData['username']);
        // print(docData['email']);
        print(docData['first name']);
      } else {}
    });
  }

  @override
  void initState() {
    if (firebaseUser != null) {
      getUserData();
      //getCurrentUser();
      super.initState();
    } else {
      return;
    }
  }
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
        endDrawer: MainDrawer(
          username: username,
          useremail: useremail,

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
