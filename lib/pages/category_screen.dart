// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
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
  @override
  void initState() {
    getCategoryFromFirebase();
    super.initState();
  }
   CollectionReference categoryRef = FirebaseFirestore.instance.collection("categories");

    List categoriesNamesList = [];
   getCategoryFromFirebase()async{
     QuerySnapshot category = await categoryRef.get();
     category.docs.forEach((element) {
       setState(() {
         categoriesNamesList.add(element.data());
       });

     });
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
      child:
      GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
             //crossAxisSpacing: 90,
          ),
          itemBuilder: (context,index){
            return categoriesNamesList == null ? Center(child: CircularProgressIndicator()):
              CategoryItem(
                categoryName: categoriesNamesList[index]['name'],
              categoryId: categoriesNamesList[index]['id'] ,
              image_category: categoriesNamesList[index]['image'],
            );
          //print(categoriesNamesList);
          },
        itemCount: categoriesNamesList.length,
          ),
      ),
    );
  }
}
