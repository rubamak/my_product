


import 'package:flutter/material.dart';
import 'package:my_product/pages/categories_pages/Beverages.dart';
import 'package:my_product/pages/categories_pages/accessories.dart';
import 'package:my_product/pages/categories_pages/clothes.dart';
import 'package:my_product/pages/categories_pages/digital_services.dart';
import 'package:my_product/pages/categories_pages/handmade.dart';
import 'package:my_product/modules/category.dart';
import 'package:my_product/pages/families_screen.dart';
import 'package:my_product/pages/home.dart';
import 'package:my_product/widgets/category_item.dart';

class HorizontelList extends StatelessWidget {
  const HorizontelList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [



          CategoryHere(
            id: 1,
            image_location: 'images/categories/food.png',
            image_caption: 'Food',
          ),
          CategoryHere(
            id: 2,
            image_location: 'images/categories/drinks.jpeg',
            image_caption: 'Beverages',
          ),
          CategoryHere(
            id: 3,
            image_location: 'images/categories/dress.jpeg',
            image_caption: 'Clothes',
          ),
          /* Category(
            image_location: 'images/categories/assecc.png',
            image_caption: 'Accessories',


          ),*/
          CategoryHere(
            id: 4,
            image_location: 'images/categories/h.png',
            image_caption: 'Handmade',
          ),
          CategoryHere(
            id: 5,
            image_location: 'images/categories/servoces.jpeg',
            image_caption: 'Digital Services',
          ),
          //كان(وتم حله من خلال الطول) خلل في ظهور الكلام تحت كل قسم لما ازودهم عشان كدا خليتهم كومنت*/
        ],
      ),
    );
  }
}

class CategoryHere extends StatelessWidget {
  final int id;
  final String image_location;
  final String image_caption;

   CategoryHere({
    required this.image_location,
    required this.image_caption,
    required this.id,
  });



//لازم اعمل هنا انه يعرض الاسر الخاصة في نوع الاكل والاسر الخاصة بنوع اللبس  بناء انه الاسرة تحمل نفس الاي ري الخاص ب النوع

    // final List horizontalcategory =[
    //   {
    //     'page':FamiliesScreen.routeName,
    //     'name':FamiliesScreen.routeName,
    //   },
    //   {},{},
    // ];
  void SelectCategory(BuildContext ctx){

    Navigator.of(ctx).pushNamed(
      //اسم الصفحة الي رح يروحها
        FamiliesScreen.routeName,
        //take this data with
        //عشان يفرق
        arguments: {
          'id': id,
          'title': image_caption,
        }
    );



  }
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        //this tap is for going to produtsList class another page
        onTap: () => SelectCategory(context),
        child: Container(
          height: 150,
          width: 180,
          child: ListTile(
              title: Image.asset(
                image_location,
                height: 200,
                width: 200,
              ),
              subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(image_caption,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              )),
        ),
      ),
    );
  }
}
