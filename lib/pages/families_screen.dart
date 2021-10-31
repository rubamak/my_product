// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls

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
}
class _FamiliesScreenState extends State<FamiliesScreen> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  CollectionReference familyStoreRef = FirebaseFirestore.instance.collection(
      "familiesStores");
  CollectionReference categoryRef = FirebaseFirestore.instance.collection(
      'categories');

  List categoryList = [];
  List familiesStoresList = [];
  var docData; // for printing
  var username; // for display to user
  var useremail;

  getUserData(String uid) async {
    //اجيب بيانات دوكيمنت واحد فقط
    DocumentReference documentReference = FirebaseFirestore.instance.collection(
        'users').doc(uid);
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
        print(docData['uid']);
        print(docData['username']);
        print(docData['email']);
        // print(docData['first name']);
        print('=============');
      } else {}
    });
  }
  getData() async {
    var response = await categoryRef.get();
    response.docs.forEach((element) {
      setState(() {
        categoryList.add(element.data());
      });
      //print(familiesStoresList);
    });

   //categoryList.clear();
    await categoryList.forEach((element) async {
      var response2 = await familyStoreRef
      // اذا خليت دا كومنت يصير تكرار في عرض البيانات
          .where('category id', isEqualTo: element['id']).get();
      // print('this is id ' + element['id']);
      // print(response2.docs);
      // print(response2.docs[0]['family store name']);
      setState(() {
        response2.docs.forEach((element) {
          print("===========================");
          print(element['category name']);
          familiesStoresList.add(element.data());
        });
      });
      // print(familiesStoresList);
    });
    // .then((value) => print(value));

    // response2.docs.forEach((element) {
    //   setState(() {
    //     familiesStoresList.add(element.data());
    //   });
    //   print(familiesStoresList);
    // });
  }

  getFamilyStore() async {
    var response = await familyStoreRef
    //.where("uid", isNotEqualTo: firebaseUser.uid,).get();
    // .where('category id', isEqualTo: categoryRef.id.toString())
        .get();
    // .then((value) => print(value));

    response.docs.forEach((element) {
      setState(() {
        familiesStoresList.add(element.data());
      });
      print(familiesStoresList);
    });
  }

  @override
  void initState() {
    if (firebaseUser != null)
      getUserData(firebaseUser.uid);
    getData();

    //getFamilyStore();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    //استقبل البيانات من خلال بوش ناميد
    final routeArg = Get.arguments;
    //= ModalRoute.of(context).settings.arguments as Map<String, Object>;
    //اخزن البيانات الي اخذتها في متغير عنشان اعرضها او اي شي
    final categoryId = routeArg['id'];
    final categoryName = routeArg['title'];

    //ميثود ال where لاوم احولها الى لستة لانه حتلف علة مجموعة عناصر ف اذا رح ترجعلي اشياء كتيييير
    // لستة مفلترة بس فيها العوائل الي لهم تصنيف نعين حسب الاي دي
    final familiesStores = DUMMY_FAMILIES_STORES.where((store) {
      return store.categoryId == categoryId;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
        ),

        title: Padding(
          padding: EdgeInsets.only(top: 1),
          child: Text("${categoryName}  Families Stores",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),),
        ),
        backgroundColor: Color(0xFF90A4AE),
        toolbarHeight: 80,
      ),
      endDrawer: MainDrawer(username: username, useremail: useremail,),
      backgroundColor: Color(0xFF90A4AE),
      body: ListView(
          children: <Widget>[
            SizedBox(height: 20,), //between them
            Container(
              height: MediaQuery.of(context).size.height - 180,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    bottomRight: Radius.circular(150),
                  )
              ),
              child: ListView(
                primary: false,
                padding: EdgeInsets.only(left: 25, right: 25),
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 45),
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height - 300,

                        child: familiesStoresList.isEmpty ? Center(
                          child: CircularProgressIndicator(),)
                            : ListView.separated(

                          separatorBuilder: (context, index) =>
                              Container(height: 1, color: grey,),
                          itemBuilder: (context, index) {
                            print('working nice');
                            print(familiesStoresList);
                            return
                              FamilyItem(
                                familyStoreId: familiesStoresList[index]['family id'],
                                familyName: familiesStoresList[index]['family store name'],
                                description: familiesStoresList[index]['store description'],
                                categoryName: familiesStoresList[index]['category name'],
                                userId: firebaseUser.uid,
                                familyImage: familiesStoresList[index]['image family store'],
                                categoryId: familiesStoresList[index]['category id'],
                              )
                            ;
                          },
                          itemCount: familiesStoresList.length,
                          //   ListView(
                          //     children: familiesStores.map((familyItem) =>
                          //         FamilyItem(
                          //           familyImage: familyItem.familyImage,
                          //             description: familyItem.description,
                          //             familyName: familyItem.familyName,
                          //             categoryId: familyItem.categoryId,
                          //             userId: familyItem.userId,
                          //           familyStoreId: familyItem.familyId,
                          //           )
                          //     ).toList(),
                          //
                          // ),
                          //   ListView(
                          //     children: familiesStores.map((familyItem) =>
                          //         FamilyItem(
                          //           familyImage: familyItem.familyImage,
                          //             description: familyItem.description,
                          //             familyName: familyItem.familyName,
                          //             categoryId: familyItem.categoryId,
                          //             userId: familyItem.userId,
                          //           familyStoreId: familyItem.familyId,
                          //           )
                          //     ).toList(),
                          //
                          // ),
                        ),
                      )
                  )
                ],
              ),
            )
          ]
      ),
    );
  }
}

