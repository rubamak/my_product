//
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class Product {
//     final String productId;
//  final String familyId;
//  //final int categoryId;
//    final String productName;
//   final String categoryName;
//   String familyName;
//    final double price;
//    //final File image ;
//    final String productImage;
//   final String description;
//
//
//
//   Product({
//      this.productId,
//       this.familyId,
//     //required this.categoryId,
//       this.categoryName,
//
//       this.productName,
//       this.familyName,
//          this.price,
//         this.productImage,
//
//         this.description,});
//
// }
// //name of provider is Products
// class Products with ChangeNotifier {
//   List <Product> productsList = [];
//   String image = '';
//
//   void add({
//      String title,  String desc,  String category,
//      String familyName,  double price,
//   }) async {
//     //هذه ريل تايم داتا بيز
//     // DatabaseReference _ref = FirebaseDatabase.instance.reference()
//     //      .child("products"); //عملت ريفرنس في مكان في الداتا بيز
//     //
//     // final String url = "https://flutter-project-9f14f-default-rtdb.firebaseio.com/products.json" ;
//     //
//     // http.post(Uri.parse( url) , body: json.encode({ //  احط بيانات في داتا بيس
//     //
//     //   "title": title,
//     //   "description": desc,
//     //   "category": category,
//     //   "familyName": familyName,
//     //   "price": price,
//     //   "image": "",
//     //
//     // })).then((res) {
//     //   print( json.decode(res.body));
//
//     CollectionReference productsRef = FirebaseFirestore.instance.collection(
//         "products");
//     // CollectionReference familyStoreRef = FirebaseFirestore.instance.collection("familiesStores");
//     // await familyStoreRef.get().then((value) {
//     //
//     // });
//     var firebaseUser = await FirebaseAuth.instance.currentUser;
//
//
//     productsList.add(
//         Product(
//             productId: productsRef.id,
//             //int.parse(json.decode(res.body)['name']),
//             familyId: "2",
//             categoryName: category,
//             familyName: familyName,
//             productName: title,
//             price: price,
//             productImage: image,
//             description: desc
//         ));
//
//     productsRef.add({
//       'family store id ': '',
//       "product name": title,
//       "price": price,
//       // "family name": familyName,
//       "description": desc,
//       "category": category
//     });
//     notifyListeners();
//     // });
//   }
//
//   void delete(String desc) {
//     productsList.removeWhere((element) => element.description == desc);
//
//     print("item deleted");
//     notifyListeners();
//   }
//
//   void deleteImage() {
//     image = '';
//   }
//
//   Future getImage(ImageSource src) async {
//     //final picker = ImagePicker();
//     final pickedImage = await ImagePicker().pickImage(
//         source: src); // pickImage(source:src) == getImage(source:src)
//     if (pickedImage != null) {
//       image = pickedImage.path;
//       notifyListeners();
//       print("image select");
//     } else {
//       print("no image selected");
//     }
//   }
//
// }
