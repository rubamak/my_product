//
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:my_product/pages/categories_pages/accessories.dart';
// import 'package:my_product/modules/category.dart';
// import 'package:my_product/pages/families_screen.dart';
// import 'package:my_product/pages/home_page.dart';
// import 'package:my_product/widgets/category_item.dart';
//
// class HorizontelList extends StatelessWidget {
//   const HorizontelList({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       Container(
//       height: 300,
//       child:
//       ListView(
//         scrollDirection: Axis.horizontal,
//         children: [
//
//
//
//           CategoryHere(
//             id: "1",
//             image_location: 'images/categories/food.png',
//             image_caption: 'Food',
//           ),
//           CategoryHere(
//             id: "2",
//             image_location: 'images/categories/drinks.jpeg',
//             image_caption: 'Beverages',
//           ),
//           CategoryHere(
//             id: "3",
//             image_location: 'images/categories/dress.jpeg',
//             image_caption: 'Clothes',
//           ),
//
//           CategoryHere(
//             id: "4",
//             image_location: 'images/categories/h.png',
//             image_caption: 'Handmade',
//           ),
//           CategoryHere(
//             id: "5",
//             image_location: 'images/categories/servoces.jpeg',
//             image_caption: 'Digital Services',
//           ),
//           //كان(وتم حله من خلال الطول) خلل في ظهور الكلام تحت كل قسم لما ازودهم عشان كدا خليتهم كومنت*/
//         ],
//       ),
//     );
//   }
// }
//
// class CategoryHere extends StatefulWidget {
//   final String id;
//   final String image_location;
//   final String image_caption;
//
//   CategoryHere({
//      this.image_location,
//      this.image_caption,
//      this.id,
//   });
//
//   @override
//   State<CategoryHere> createState() => _CategoryHereState();
// }
//
// class _CategoryHereState extends State<CategoryHere> {
//   void SelectCategory(BuildContext ctx){
//
//     Navigator.of(ctx).pushNamed(
//       //اسم الصفحة الي رح يروحها
//         FamiliesScreen.routeName,
//         //take this data with
//         //عشان يفرق
//         arguments: {
//           'id': widget.id,
//           'title': widget.image_caption,
//         }
//     );
//
//
//
//   }
//   List categoriesNamesList = [];
//   CollectionReference categoryRef = FirebaseFirestore.instance.collection("categories");
//
//   getCategory()async{
//     await categoryRef.get().then((coll){
//       coll.docs.forEach((document) {
//         categoriesNamesList.add(document.data());
//       });
//     });
//     /*var category = await categoryRef.get();
//     category.docs.forEach((element) {
//       setState(() {
//         categoriesNamesList.add(element.data());
//
//       });
//       print(categoriesNamesList[0]['name']);
//
//    });*/
//   }
//   @override
//   void initState() {
//     getCategory();
//     super.initState();
//   }
//   Widget buildCat(){
//     return Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: InkWell(
//
//         //this tap is for going to produtsList class another page
//         onTap: () => SelectCategory(context),
//     child: Container(
//     height: 150,
//     width: 180,
//     child:
//     ListView.builder(
//
//     itemBuilder: (context,index)=>
//     CategoryItem(
//     categoryName: categoriesNamesList[index]['name'],
//     categoryId: categoriesNamesList[index]['id'] ,
//     image_category: categoriesNamesList[index]['image'],
//
//     ),
//     itemCount: categoriesNamesList.length,
//     ))));
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: InkWell(
//
//         //this tap is for going to produtsList class another page
//         onTap: () => SelectCategory(context),
//         child: Container(
//             height: 150,
//             width: 180,
//             child:
//             ListView.builder(
//
//               itemBuilder: (context,index)=>
//                   CategoryItem(
//                     categoryName: categoriesNamesList[index]['name'],
//                     categoryId: categoriesNamesList[index]['id'] ,
//                     image_category: categoriesNamesList[index]['image'],
//
//                   ),
//               itemCount: categoriesNamesList.length,
//             )
//           // ListTile(
//           //     title: Image.asset(
//           //       widget.image_location,
//           //       height: 200,
//           //       width: 200,
//           //     ),
//           //     subtitle: Container(
//           //       alignment: Alignment.topCenter,
//           //       child: Text(widget.image_caption,
//           //           style:
//           //               TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
//           //     )),
//         ),
//       ),
//     );
//   }
// }
