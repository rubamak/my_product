
import 'package:flutter/material.dart';
import '../pages/families_screen.dart';

class CategoryItem extends StatelessWidget {

 final String categoryId ;
 final String? categoryName;
 final String? image_category;

  CategoryItem({ required this.categoryId, this.categoryName, this.image_category});

  void SelectCategory(BuildContext ctx){
    Navigator.of(ctx).pushNamed(
      //اسم الصفحة الي رح يروحها
      FamiliesScreen.routeName,
      //take this data with
        //عشان يفرق
      arguments: {
        'id': categoryId,
        'title': categoryName,
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
        splashColor: Colors.black,
      onTap: () => SelectCategory(context),



     child: Card(
      // color:  grey,
         child: Column(
           children:[
             Container(
               child: ClipRRect(

                 borderRadius: BorderRadius.circular(20),
                 child:Image.asset(image_category!,width: double.infinity,height: 100,),
               ),
               margin: EdgeInsets.all(20),
             ),
              Text(categoryName!,
           textAlign: TextAlign.center,
           style: TextStyle(fontSize: 35,fontWeight: FontWeight.w600),),
            ]
         ),
     )
    );
  }
}
