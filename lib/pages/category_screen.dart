import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/widgets/category_item.dart';
import 'package:my_product/widgets/main_drawer.dart';

import '../dummy_data.dart';

class CategoryScreen extends StatelessWidget {
   static const routeName = '/category-screen';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /*appBar: AppBar(

        backgroundColor: blue,
        title: Text("Categories Screen",),
      ),*/
      body: Container(
        //color: Color(0xFF90A4AE),

      child: GridView(


          padding: const EdgeInsets.all(10),

            children:
                //اما طريقة الماب واما girdView.builder
            DUMMY_CATEGORY.map((catData) =>
             CategoryItem(catData.categoryId,catData.categoryName,catData.image_location)

            ).toList(),

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 1,
                childAspectRatio:3/2,
                mainAxisSpacing:100, crossAxisCount: 1,

              ),


          ),
      ),
      //drawer: MainDrawer(),

    );
  }
}
