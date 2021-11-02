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
import 'package:my_product/pages/products_screen.dart';
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
  FamiliesScreen({
    this.selectedCategory,
    this.userId, this.
    familyStoreId, this.categoryId,
    this.categoryName,
    this.familyName,
    this.description, this.familyImage});
  final String userId;
  final String familyStoreId ;
  final String categoryId;
  final String categoryName;
  final String familyName;
  final String description;
  final String familyImage;
}

class _FamiliesScreenState extends State<FamiliesScreen> {
  void selectFamily(BuildContext context){
    // Navigator.of(context).pushNamed(
    //     ProductsScreen.routeName,
    //     arguments: {
    //       'id': widget.familyStoreId,
    //       'name': widget.familyName,


  }

  void chatWithFamily (BuildContext context){
    // Navigator.of(context).pushNamed(
    //     SingleChatScreen.routeName,
    //     arguments: {
    //       'id': widget.familyStoreId,
    //       'name': widget.familyName,
    //     }
    //
    // );
  }
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
              familiesStoresList = specifiedDoc;
            });
          } else {
            print('No Docs Found');
          }
        });
      } catch (e) {
        print('Error Fetching Data:$e');
      }
    }
  }
  @override
  void initState() {
    if (firebaseUser != null && firebaseUser.uid != null){
      getUserData(firebaseUser.uid);
      print("yseeeeee");
    }else{
      fetchSpecifiedFamilyStore();
    }


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
            //Navigator.of(context).pop();
            Get.back();
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
                    separatorBuilder: (context, i) => Container(height: 1, color: grey,),
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: (){
                          Get.to(()=> ProductsScreen(selectedFamilyStore: familiesStoresList.docs[i],));
                          //ProductsScreen(selectedFamilyStore: ,));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Hero(
                                      tag: familiesStoresList.docs[i].data()['family id'].toString(),
                                      child:
                                      familiesStoresList.docs[i].data()['image family store'].toString() != null ?
                                      Image.network(familiesStoresList.docs[i].data()['image family store'].toString(),
                                        fit: BoxFit.cover,
                                        height: 75,
                                        width: 75,
                                      ):
                                      Image.network("https://previews.123rf.com/images/thesomeday123/thesomeday1231712/thesomeday123171200009/91087331-default-avatar-profile-icon-for-male-grey-photo-placeholder-illustrations-vector.jpg",
                                        fit: BoxFit.cover,
                                        height: 75,
                                        width: 75,
                                      )    ),

                                  SizedBox(width: 10,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[

                                      Text(familiesStoresList.docs[i].data()['family store name'].toString()
                                          ??"none",style: TextStyle(color:black,fontSize: 17,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 5,),

                                      Container(
                                          width: 200,
                                          child:
                                          Text(familiesStoresList.docs[i].data()['store description'].toString()??"none",
                                            softWrap: true,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(fontSize: 17,fontWeight: FontWeight.normal,color: grey),)
                                      ),
                                      Text("${familiesStoresList.docs[i].data()['category name'].toString()} Store" ??"none",
                                        style: TextStyle(color:black),),
                                    ],
                                  )
                                ],
                              ),
                            ),

                           firebaseUser!= null? IconButton(
                              onPressed: ()=> chatWithFamily(context),
                              // Navigator.of(context).pushNamed(ChatScreen.routeName);
                              icon: Icon(Icons.chat_outlined,color: black,),
                              color: black,
                            ): SizedBox(width: 1,),
                          ],
                        ),
                      );
                      // return FamilyItem(
                      //   familyStoreId: familiesStoresList.docs[i].data()['family id'].toString(),
                      //   familyName: familiesStoresList.docs[i].data()['family store name'].toString(),
                      //   description: familiesStoresList.docs[i].data()['store description'].toString(),
                      //   categoryName: familiesStoresList.docs[i].data()['category name'].toString(),
                      //   userId: firebaseUser ==null ?" no user": firebaseUser.uid,
                      //   familyImage: familiesStoresList.docs[i].data()['image family store'].toString(),
                      //   categoryId: familiesStoresList.docs[i].data()['category id'].toString(),
                      // );
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