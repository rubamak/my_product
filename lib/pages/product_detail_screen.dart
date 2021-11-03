import 'dart:io';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/dummy_data.dart';
import 'package:my_product/pages/product_details_latest_products.dart';
import 'package:my_product/pages/taps_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-details';

  // final Function toggleFavorites;
  // final Function isProductFavorite;

  final DocumentSnapshot<Map<String, dynamic>> selectedProduct;
  ProductDetailScreen({this.selectedProduct});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF90A4AE),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Details',
          style: TextStyle(
            fontSize: 18,
            color: black,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_horiz),
            color: black,
          ),
        ],
      ),




    );



//     final productId = ModalRoute.of(context).settings.arguments as Object;
//
//     //هنا ليس لست كاملة وانما عنصر واحد فقط لانه فيرست وير
//     // final selectedProduct =
//     // DUMMY_PRODUCTS.firstWhere((product) => product.productId == productId);
//
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: black),
//         toolbarHeight: 100,
//         elevation: 0,
//         backgroundColor: basicColor,
//         centerTitle: true,
//         title: Text("Ll",
//           //"${selectedProduct.productName} Information",
//           style: TextStyle(
//             color: black,
//             fontWeight: FontWeight.bold,
//             fontSize: 23,
//           ),
//         ),
//       ),
//       backgroundColor: basicColor,
//       body: ListView(children: [
//         Stack(
//             children:
//             <Widget>[
//               Container(
//                 height: MediaQuery.of(context).size.height - 82,
//                 width: MediaQuery.of(context).size.width,
//                 color: Colors.transparent,
//               ),
//               Positioned(
//                 top: 75,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(45),
//                         topRight: Radius.circular(45)),
//                     color: white,
//                   ),
//                   height: MediaQuery.of(context).size.height - 100,
//                   width: MediaQuery.of(context).size.width,
//                 ),
//               ),
//               Positioned(
//                 top: 30,
//                 left: (MediaQuery.of(context).size.width / 2) - 100,
//                 child: Hero(
//                   tag: productId,
//                   child: Container(
//                     decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage(
//                               ""//selectedProduct.productImage,
//                             ),
//                             fit: BoxFit.cover)),
//                   ),
//                 ),
//                 height: 200,
//                 width: 200,
//               ),
//               Positioned(
//                 top: 250,
//                 left: 25,
//                 right: 25,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   // crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//
//                      Text(" Name:  ",//${selectedProduct.productName} ",
//                       style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,color:black
//                       ),
//                     ),
//                     SizedBox(height: 15),
//
//
//                     Text( "price: ",
//                         //"${selectedProduct.price} ",
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: black,
//                       ),
//                     ),
//                     SizedBox(height: 15),
//
//                     Text(" description: ",
//                         //"${selectedProduct.description} ",
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: black,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 20),
//                     Text(" Owner Name: ",
//                         //"${selectedProduct.familyName} ",
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: black,
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                     Text(" Category: ",
//                         //"${selectedProduct.categoryName} ",
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: black,
//
//                       ),
//
//                     ),
//
//
//
//
//
//
//
//
//
//                   ],
//                 ),
//
//
// //           Container(
// //             height: MediaQuery.of(context).size.height - 180,
// //             decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.only(topLeft: Radius.circular(100),bottomRight:Radius.circular(150),)),
// //
// //             child:Padding(
// //               padding: const EdgeInsets.only(top: 20,right: 40,left: 40),
// //               child: Column(
// //                 children: [
// //                   Hero(
// //                   tag: productId,
// //                       child: Image(
// //                 image: AssetImage(selectedProduct.productImage,),
// //                 fit: BoxFit.contain,
// //                     height: MediaQuery.of(context).size.height - 700,
// //                 width: MediaQuery.of(context).size.width* 0.5,
// //               )
// //               )
// //                   ,
// //                   Text("Name: ${selectedProduct.productName} ",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
// //
// //                   Text("Price: ${selectedProduct.price} SR",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
// //                   Text(" Products Details: ${selectedProduct.description}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500,),
// //                     softWrap: true,),
// //                   const SizedBox(height: 20,),
// //                   Text(" Store Name: ${selectedProduct.familyName}",style:
// //                   const TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
// //
// //                   Text(" Category: ${selectedProduct.categoryName}",style:
// //                   const TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
// //
// //                 ],
// //               ),
// //             ),
// //
// //
// //             //Image.file(File(selectedProduct.productImage)),
// //           ),
// //
// //
// // ]
// //       ),
//
//
//
//               ),
//
//             ]
//         )
//       ]
//
//       ),
//       floatingActionButton: FloatingActionButton(
//           backgroundColor: white,
//           onPressed: () {},
//               //toggleFavorites(productId),
//           child: Icon(
//             //isProductFavorite(productId) ? Icons.star :
//             Icons.star_border,
//             color: grey,
//           )
//         // Icons.star_border_outlined,color: Colors.red ),
//       ),
//
//     );
  }
}
