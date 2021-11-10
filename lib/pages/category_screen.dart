// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/pages/families_screen.dart';
import 'package:my_product/widgets/main_drawer.dart';
import 'package:get/get.dart';

// ignore: unused_import
import '../dummy_data.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = '/category-screen';

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  QuerySnapshot<Map<String, dynamic>> categoryList;

  @override
  void initState() {
    getCategories();
    if(firebaseUser != null ){
      getUserData();
    }
    super.initState();
  }
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
        print(docData['first name']);
        // print(docData['email']);
        //print(docData['first name']);
      } else {}
    });
  }

  Future getCategories() async {
    try {
      await FirebaseFirestore.instance.collection('categories').get().then((catDocs) async {
        if (catDocs != null && catDocs.docs.isEmpty == false) {
          setState(() {
            categoryList = catDocs;
          });
        } else {
          print('No Docs Found');
        }
      });
    } catch (e) {
      print('Error Fetching Data');
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
            'Categories',
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
      body:   Container(
    height: MediaQuery.of(context).size.height - 130,
    decoration: BoxDecoration(
    color: white,
    borderRadius: BorderRadius.only(topLeft: Radius.circular(100),
    //bottomRight:Radius.circular(150),
    )),
    child: categoriesFlowList(context)
      ),
    );
  }

  Widget categoriesFlowList(BuildContext context){
    if(categoryList!=null && categoryList.docs.isEmpty==false){
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          //crossAxisSpacing: 90,
        ),
        itemCount: categoryList.docs.length,
        itemBuilder: (context, i) {
          return InkWell(
              borderRadius: BorderRadius.circular(100),
              splashColor: black,
              child: Card(

                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),


                child: Column(

                    children: [
                  Container(

                    padding: EdgeInsets.all(30),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          categoryList.docs[i].data()['image'].toString(),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.13,
                        )),
                    margin: EdgeInsets.all(20),
                  ),
                  Text(
                    categoryList.docs[i].data()['name'].toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600,color:black),
                  ),
                ]),
              ),
            onTap: (){
               // Navigator.of(context).push(new MaterialPageRoute(
               //     builder: (BuildContext context) =>
               //         FamiliesScreen( selectedCategory: categoryList.docs[i],)));
              Get.to(()=> FamiliesScreen(selectedCategory: categoryList.docs[i],));

            },
          );
        },
      );
    }else{
      return Center(child: CircularProgressIndicator());
    }
  }

}
