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
      body: Container(
      child: GridView(
          padding: const EdgeInsets.all(10),
            children:
                //اما طريقة الماب واما girdView.builder
            DUMMY_CATEGORY.map((catData) =>
                CategoryItem(
               categoryName: catData.categoryName,
               image_category: catData.image_location, categoryId: catData.categoryId,)).toList(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 1,
                childAspectRatio:3/2,
                mainAxisSpacing:100, crossAxisCount: 1,
              ),
          ),
      ),
    );
  }
}
