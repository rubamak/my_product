// import 'dart:io';
// import 'dart:ui';
// import 'package:like_button/like_button.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:my_product/color/my_colors.dart';
// import 'package:my_product/pages/product_details_latest_products.dart';
// import 'package:my_product/pages/product_detail_screen.dart';
//
// class ProductItem extends StatelessWidget {
//   String categoryId;
//   String categoryName;
//   String familyId;
//    String uid;
//    double price;
//    String productImage;
//    String description;
//    String productName;
//   String  productId;
//
//   ProductItem( {
//     this.productId,
//     this.categoryId,
//     this.familyId,
//     this.uid,
//     this.categoryName,
//     this.productName,
//     this.productImage,  this.price,
//          this.description
//   });
//
//   void selectProductItem(BuildContext ctx) {
//     Navigator.of(ctx).pushNamed(
//         ProductDetailScreen.routeName,
//         arguments: {
//           'id': productId,
//           'name' : productName,
//         }
//         );
//       }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(40),
//         onTap: ()=> selectProductItem(context),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Container(
//               child: Row(
//                 children: <Widget>[
//                   Hero(
//                       tag:productId,
//                       child: Image(
//                     image: AssetImage(productImage),
//                     fit: BoxFit.cover,
//                     height: 75,
//                     width: 75,
//                   )
//                   ),
//
//                   SizedBox(width: 10,),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(productName,
//                         softWrap: true,
//                         textAlign: TextAlign.justify,
//                         style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: black),),
//                       Text("${price} SR", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: black),),
//
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             // IconButton(
//             //   onPressed: (){},
//             //   icon: Icon(Icons.favorite_border),
//             //   color: black,
//             // ),
//             Container(
//               child: LikeButton(
//               onTap:  onLikeButtonTapped,
//
//               //likeCount: 1,
//             ),
//             )
//
//           ],
//         ),
//         // child: Card(
//         //   child: Container(
//         //
//         //     padding: EdgeInsets.all(50),
//         //     margin: EdgeInsets.all(20),
//         //     child: Column(
//         //       children:[
//         //         Text(familyName,
//         //         //textAlign: TextAlign.center,
//         //         style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),),
//         //        Text(description, style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
//         //     ])
//         //     ,
//         //
//         //     decoration: BoxDecoration(
//         //       color: Colors.lightBlue[50],
//         //       borderRadius: BorderRadius.circular(50),
//         //     ),
//         //
//         //   ),
//         // )
//       ),
//     );
//   }
//  Future<bool> onLikeButtonTapped(bool isLiked) async{
//     return !isLiked;
//   }
// }
