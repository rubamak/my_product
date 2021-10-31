
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:my_product/color/my_colors.dart';
import '../pages/families_screen.dart';

class CategoryItem extends StatelessWidget {

 final String categoryId ;
 final String categoryName;
 // ignore: non_constant_identifier_names
 final String image_category;

  CategoryItem({  this.categoryId,  this.categoryName,  this.image_category});

  void SelectCategory(BuildContext ctx){
    //Navigator.of(ctx).pushNamed(
      Get.toNamed(
      //اسم الصفحة الي رح يروحها
      FamiliesScreen.routeName,
      //take this data with
        //عشان يفرق
      arguments:{
        'id': categoryId,
        'title': categoryName,
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
        splashColor: black,
      onTap: () => SelectCategory(context),



     child: Card(

      // color:  grey,
         child: Column(
           children:[
             Container(
               padding: EdgeInsets.all(30),
               child: ClipRRect(

                 borderRadius: BorderRadius.circular(20),
                 child: Image.network(
                   image_category,
                   width: double.infinity,height: MediaQuery.of(context).size.height * 0.2,)
               ),
               margin: EdgeInsets.all(20),
             ),
              Text(categoryName,
           textAlign: TextAlign.center,
           style: TextStyle(fontSize: 35,fontWeight: FontWeight.w600,color:black),),
            ]
         ),
     )
    );
  }
}
