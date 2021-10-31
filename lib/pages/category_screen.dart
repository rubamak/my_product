// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/pages/families_screen.dart';
import 'package:my_product/widgets/category_item.dart';
// ignore: unused_import
import 'package:my_product/widgets/main_drawer.dart';

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
    super.initState();
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
      backgroundColor: white,
      body: Container(
        child: categoriesFlowList(context),
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
              borderRadius: BorderRadius.circular(50),
              splashColor: black,
              child: Card(
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.all(30),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          categoryList.docs[i].data()['image'].toString(),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.2,
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
               Navigator.of(context).push(new MaterialPageRoute(
                   builder: (BuildContext context) =>
                       FamiliesScreen( selectedCategory: categoryList.docs[i],)));
            },
          );
        },
      );
    }else{
      return Center(child: CircularProgressIndicator());
    }
  }

}
