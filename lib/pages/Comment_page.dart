// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:my_product/color/my_colors.dart';
// import 'package:my_product/pages/product_details.dart';
// import 'package:my_product/pages/product_details_latest_products.dart';
// import 'package:get/get.dart';
//
//
// class CommentsPage extends StatefulWidget {
//   var productId;
//   CommentsPage({this.productId});
//
//   @override
//   _CommentsPage createState() => _CommentsPage();
// }
//
// class _CommentsPage extends State<CommentsPage> {
//   User firebaseUser = FirebaseAuth.instance.currentUser;
//   // DocumentSnapshot <Map<String, dynamic>> familyStore;
//   QuerySnapshot<Map<String, dynamic>> commmentsList;
//   //دي اللسته المخزنه فيها الاشياء اللي ف الفيربيس
//   DocumentSnapshot<Map<String, dynamic>> docData; // for printing
//   var username; // for display to user
//   var useremail;
//   var CommentsController = TextEditingController()..text = "";
//
//   getUserData(String uid) async {
//     //اجيب بيانات دوكيمنت واحد فقط
//     //get will return docs Query snapshot
//     await FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) async{
//       //value.data is the full fields for this doc
//       if (value.exists) {
//         setState(() {
//           docData = value;
//           useremail = docData['email'];
//           username = docData['username'];
//           // print(value.id);
//         });
//         print(docData['uid']);
//         print(docData['username']);
//         print(docData['email']);
//         // print(docData['first name']);
//         print('======================');
//       } else {
//       }
//     });
//     try {
//       await FirebaseFirestore.instance.collection('comments')
//           .where('product id', isNotEqualTo: widget.productId)
//           .orderBy('addedAt',descending: true)
//           .get().then((specifiedDoc) async {
//         if (specifiedDoc != null && specifiedDoc.docs.isEmpty == false) {
//           setState(() {
//             commmentsList = specifiedDoc;
//           });
//
//         } else {
//           print('No Docs Found');
//         }
//       });
//     } catch (e) {
//       print('Error Fetching Data$e');
//     }
//     fetchSpecifiedProduct();
//   }
//   Future fetchSpecifiedProduct() async {
//
//     //هذا اللي يجيب ال doc على الابلكيشن
//     try {
//       await FirebaseFirestore.instance.collection('comments')
//           .where('product id', isEqualTo: widget.productId)
//           .orderBy('addedAt',descending: true)
//           .get().then((specifiedDoc) async {
//         if (specifiedDoc != null && specifiedDoc.docs.isEmpty == false) {
//           setState(() {
//             commmentsList = specifiedDoc;
//           });
//
//         } else {
//           print('No Docs Found');
//         }
//       });
//     } catch (e) {
//       print('Error Fetching Data$e');
//     }
//     //}
// //print( " hereeree ${productsList.docs[1].data()}");
//     // يطبع كل منتج ف لازم يكون الانديس هو i
//
//   }
//   @override
//   void initState() {
//     fetchSpecifiedProduct();
//     super.initState();
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 500,
//       height: 500,
//       child: commmentsList == null ? SizedBox(height: 0,)
//         :ListView.builder(
//         itemCount: commmentsList.docs.length ,
//         shrinkWrap: true,
//         itemBuilder: (BuildContext context, int i) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//               commmentsList.docs.isEmpty ? CircularProgressIndicator(): Single_prod(
//               comment: commmentsList.docs[i].data()['Comment'],
//               selectedPro: commmentsList.docs[i],
//                           ),
//                     TextField(
//                       controller: CommentsController,
//                       decoration:
//                           InputDecoration(hintText: "write your comment"),
//                     ),
//                   ]
//             ),
//           );
//         }
//
//
//     ),
//       );
//   }
// }
//
// class Single_prod extends StatelessWidget {
//   final id;
//   final comment;
//
//   final DocumentSnapshot<Map<String, dynamic>>  selectedPro ;
//
//   Single_prod(
//
//       {
//         this.id,
//         this.comment,
//         this.selectedPro
//       });
//
//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//         child: Material(
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           Text(comment,
//                             softWrap: true,
//                             overflow: TextOverflow.fade,
//                             style: TextStyle(
//                                 color: black,
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(
//                             height: 5,),
//                         ],
//                       ),
//
//                     ),
//                   ),
//         ),
//     );
//   }
// }
//
//
//
//
//
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get_core/src/get_main.dart';
// // import 'package:get/get_navigation/src/extension_navigation.dart';
// // import 'package:my_product/color/my_colors.dart';
// //
// // class CommentsPage extends StatefulWidget {
// //   @override
// //   State<CommentsPage> createState() => CommentPageState();
// //   var productId;
// //
// //   CommentsPage({this.productId});
// // }
// //
// // class CommentPageState extends State<CommentsPage> {
// //   TextEditingController CommentsController = TextEditingController();
// //
// //   User firebaseUser = FirebaseAuth.instance.currentUser;
// //
// //   QuerySnapshot<Map<String, dynamic>> commmentsList;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         backgroundColor: white,
// //         appBar: AppBar(
// //           backgroundColor: basicColor,
// //           iconTheme: IconThemeData(color: black),
// //           toolbarHeight: 100,
// //           centerTitle: true,
// //           elevation: 0,
// //           leading: IconButton(
// //             icon: Icon(Icons.arrow_back_ios, color: black),
// //             onPressed: () {
// //               Get.back();
// //             },
// //             color: black,
// //           ),
// //           title: Padding(
// //             padding: EdgeInsets.only(top: 1),
// //             child: Text(
// //               "comments page",
// //               style: TextStyle(color: black, fontSize: 25),
// //             ),
// //           ),
// //         ),
// //         body: Column(children: [
// //           Expanded(
// //               child: Container(
// //             height: MediaQuery.of(context).size.height - 100,
// //             decoration: BoxDecoration(
// //                 color: white,
// //                 borderRadius: BorderRadius.only(
// //                   topLeft: Radius.circular(120),
// //                 )),
// //           child:ListView.separated(
// //           itemBuilder: (context, i) {
// //       return Container(
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: <Widget>[
// //             Container(
// //               child: Row(
// //                 children: <Widget>[
// //                   SizedBox(
// //                     width: 10,
// //                   ),
// //                   Column(
// //                     mainAxisAlignment:
// //                     MainAxisAlignment.center,
// //                     crossAxisAlignment:
// //                     CrossAxisAlignment.start,
// //                     children: <Widget>[
// //                       Text(commmentsList.docs[i].data()['Comment'].toString() ??
// //                           "none",
// //                         softWrap: true,
// //                         overflow: TextOverflow.fade,
// //                         style: TextStyle(
// //                             color: black,
// //                             fontSize: 17,
// //                             fontWeight: FontWeight.bold),
// //                       ),
// //                       SizedBox(
// //                         height: 5,
// //                       ),
// //                     ],
// //                   )
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       );
// //     },
// //
// //               )
// //               )
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(30),
// //             child: TextField(
// //               controller: CommentsController,
// //               decoration:
// //               InputDecoration(
// //                   hintText: "write your comment",
// //                    hintStyle: TextStyle(
// //                      color: grey,
// //                    )),
// //             ),
// //           )
// //         ]));
// //   }
// // }
