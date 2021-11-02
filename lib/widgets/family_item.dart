//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:my_product/color/my_colors.dart';
// import 'package:my_product/pages/drawer_section_pages/single_chat_screen.dart';
// import 'package:my_product/pages/products_screen.dart';
// import 'package:get/get.dart';
//
// import 'dart:io';
// class FamilyItem extends StatefulWidget {
//   final String userId;
//   final String familyStoreId ;
//   final String categoryId;
//   final String categoryName;
//   final String familyName;
//   final String description;
//   final String familyImage;
//
//    FamilyItem({
//      this.familyStoreId,
//      this.familyName,
//      this.description,
//      this.familyImage,
//      this.categoryName,
//      this.userId,
//      this.categoryId
//   });
//
//   @override
//   State<FamilyItem> createState() => _FamilyItemState();
// }
//
// class _FamilyItemState extends State<FamilyItem> {
//   void selectFamily(BuildContext context){
//     Navigator.of(context).pushNamed(
//       ProductsScreen.routeName,
//       arguments: {
//         'id': widget.familyStoreId,
//         'name': widget.familyName,
//       }
//     );
//
//   }
//
//   void chatWithFamily (BuildContext context){
//     Navigator.of(context).pushNamed(
//       SingleChatScreen.routeName,
//       arguments: {
//         'id': widget.familyStoreId,
//         'name': widget.familyName,
//       }
//
//     );
//   }
//   User firebaseUser = FirebaseAuth.instance.currentUser;
//   QuerySnapshot<Map<String, dynamic>> familiesStoresList;
//   DocumentSnapshot<Map<String, dynamic>> docData; // for printing
//   var username; // for display to user
//   var useremail;
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
//     fetchSpecifiedFamilyStore();
//   }
//
//   Future fetchSpecifiedFamilyStore() async {
//     //print('Inside Fetching Data UID=${docData.id}');
//     //print('Inside Fetching Data CatID=${widget.selectedCategory.id}');
//     if(firebaseUser != null && firebaseUser.uid != null){
//       try {
//         await FirebaseFirestore.instance.collection('familiesStores')
//           //  .where('category id', isEqualTo: widget.selectedCategory.id)
//             .where('uid', isNotEqualTo: docData.id)
//             .get().then((specifiedDoc) async {
//           if (specifiedDoc != null && specifiedDoc.docs.isEmpty == false) {
//             setState(() {
//               familiesStoresList=specifiedDoc;
//             });
//           } else {
//             print('No Docs Found');
//           }
//         });
//       } catch (e) {
//         print('Error Fetching Data');
//       }
//     }else{
//       try {
//         await FirebaseFirestore.instance.collection('familiesStores')
//             //.where('category id', isEqualTo: widget.selectedCategory.id)
//             .get().then((specifiedDoc) async {
//           if (specifiedDoc != null && specifiedDoc.docs.isEmpty == false) {
//             setState(() {
//               familiesStoresList = specifiedDoc;
//             });
//           } else {
//             print('No Docs Found');
//           }
//         });
//       } catch (e) {
//         print('Error Fetching Data:$e');
//       }
//     }
//   }
//   @override
//   void initState() {
//     if (firebaseUser != null && firebaseUser.uid != null){
//       getUserData(firebaseUser.uid);
//     }
//     fetchSpecifiedFamilyStore();
//     super.initState();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//           child: InkWell(
//             onTap: (){
//              // Get.to(()=> ),
//                   //ProductsScreen(selectedFamilyStore: ,));
//             },
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Container(
//                 child: Row(
//                   children: <Widget>[
//                     Hero(
//                       tag: widget.familyStoreId,
//                         child:
//                             widget.familyImage != null ?
//                         Image.network(widget.familyImage,
//                       fit: BoxFit.cover,
//                       height: 75,
//                       width: 75,
//                         ):
//                             Image.network("https://previews.123rf.com/images/thesomeday123/thesomeday1231712/thesomeday123171200009/91087331-default-avatar-profile-icon-for-male-grey-photo-placeholder-illustrations-vector.jpg",
//                               fit: BoxFit.cover,
//                               height: 75,
//                               width: 75,
//                             )                    ),
//
//                     SizedBox(width: 10,),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//
//                          Text(widget.familyName??"none",style: TextStyle(color:black,fontSize: 17,fontWeight: FontWeight.bold),),
//                          SizedBox(height: 5,),
//
//                       Container(
//                         width: 200,
//                           child:
//                               Text(widget.description??"none",
//                               softWrap: true,
//                                overflow: TextOverflow.fade,
//                                 style: TextStyle(fontSize: 17,fontWeight: FontWeight.normal,color: grey),)
//                       ),
//                         Text("${widget.categoryName} Store" ??"none",style: TextStyle(color:black),),
//                       ],
//                     )
//                 ],
//                 ),
//               ),
//
//               IconButton(
//                 onPressed: ()=> chatWithFamily(context),
//                  // Navigator.of(context).pushNamed(ChatScreen.routeName);
//                 icon: Icon(Icons.chat_outlined,color: black,),
//                 color: black,
//               )
//             ],
//             ),
//           ),
//     );
//   }
// }
