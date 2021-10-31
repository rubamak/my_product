import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/dummy_data.dart';
import 'package:my_product/modules/family_store.dart';
import 'package:my_product/pages/taps_screen.dart';
import 'package:my_product/widgets/family_item.dart';
import 'package:my_product/widgets/main_drawer.dart';
import 'dart:io';
import 'package:get/get.dart';

class FamiliesScreen extends StatefulWidget {
  static const routeName = '/families_categories';
  @override
  State<FamiliesScreen> createState() => _FamiliesScreenState();
  final DocumentSnapshot<Map<String, dynamic>> selectedCategory;
  FamiliesScreen({this.selectedCategory});
}

class _FamiliesScreenState extends State<FamiliesScreen> {
  User firebaseUser = FirebaseAuth.instance.currentUser;
  QuerySnapshot<Map<String, dynamic>> familiesStoresList;
  DocumentSnapshot<Map<String, dynamic>> docData; // for printing
  var username; // for display to user
  var useremail;

  getUserData(String uid) async {
    //اجيب بيانات دوكيمنت واحد فقط
    //get will return docs Query snapshot
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) async{
      //value.data is the full fields for this doc
      if (value.exists) {
        setState(() {
          docData = value;
          useremail = docData['email'];
          username = docData['username'];
          // print(value.id);
        });
        print(docData['uid']);
        print(docData['username']);
        print(docData['email']);
        // print(docData['first name']);
        print('======================');
      } else {
      }
    });
    fetchSpecifiedFamilyStore();
  }

  Future fetchSpecifiedFamilyStore() async {
    //print('Inside Fetching Data UID=${docData.id}');
    print('Inside Fetching Data CatID=${widget.selectedCategory.id}');
    if(firebaseUser != null && firebaseUser.uid != null){
      try {
        await FirebaseFirestore.instance.collection('familiesStores')
            .where('category id', isEqualTo: widget.selectedCategory.id)
            .where('uid', isNotEqualTo: docData.id)
            .get().then((specifiedDoc) async {
          if (specifiedDoc != null && specifiedDoc.docs.isEmpty == false) {
            setState(() {
              familiesStoresList=specifiedDoc;
            });
          } else {
            print('No Docs Found');
          }
        });
      } catch (e) {
        print('Error Fetching Data');
      }
    }else{
      try {
        await FirebaseFirestore.instance.collection('familiesStores')
            .where('category id', isEqualTo: widget.selectedCategory.id)
            .get().then((specifiedDoc) async {
          if (specifiedDoc != null && specifiedDoc.docs.isEmpty == false) {
            setState(() {
              familiesStoresList=specifiedDoc;
            });
          } else {
            print('No Docs Found');
          }
        });
      } catch (e) {
        print('Error Fetching Data');
      }
    }
  }
  @override
  void initState() {
    if (firebaseUser != null && firebaseUser.uid != null){
      getUserData(firebaseUser.uid);
    }
    fetchSpecifiedFamilyStore();
    super.initState();

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
            Navigator.of(context).pop();
          },
          color: black,
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 1),
          child: Text(
            "${widget.selectedCategory.data()['name'].toString()}  Families Stores",
            style: TextStyle(
              color: black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
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
      body: ListView(children: <Widget>[
        SizedBox(
          height: 20,
        ), //between them
        familyStoreFlowList(context),
      ]),
    );
  }

  Widget familyStoreFlowList(BuildContext context) {
    if (familiesStoresList != null) {
      return Container(
        height: MediaQuery.of(context).size.height - 180,
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100),
               //bottomRight: Radius.circular(90),
            )),
        child: ListView(
          primary: false,
          physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          padding: EdgeInsets.only(left: 25, right: 25),
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 45),
                child: Container(
                  height: MediaQuery.of(context).size.height - 300,
                  child: familiesStoresList.docs.isEmpty
                      ? Center(
                    child: Text("no elements",style: TextStyle(color: black),),
                  )
                      : ListView.separated(
                    itemCount: familiesStoresList.docs.length,
                    separatorBuilder: (context, i) => Container(
                      height: 1,
                      color: grey,
                    ),
                    itemBuilder: (context, i) {
                      return FamilyItem(
                        familyStoreId: familiesStoresList.docs[i].data()['family id'].toString(),
                        familyName: familiesStoresList.docs[i].data()['family store name'].toString(),
                        description: familiesStoresList.docs[i].data()['store description'].toString(),
                        categoryName: familiesStoresList.docs[i].data()['category name'].toString(),
                        userId: firebaseUser.uid,
                        familyImage: familiesStoresList.docs[i].data()['image family store'].toString(),
                        categoryId: familiesStoresList.docs[i].data()['category id'].toString(),
                      );
                    },
                  ),
                ))
          ],
        ),
      );
    } else {
      return Container(
          height: MediaQuery.of(context).size.height - 180,
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100),
                bottomRight: Radius.circular(150),
              )),
          child: Center(child: CircularProgressIndicator()));
    }
  }
}