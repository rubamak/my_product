import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:like_button/like_button.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/modules/product.dart';
import 'package:my_product/widgets/main_drawer.dart';
import 'package:my_product/widgets/product_item.dart';
import 'package:my_product/dummy_data.dart';
import 'package:my_product/pages/login.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = '/favorite-screen';
  final DocumentSnapshot<Map<String, dynamic>> selectedFavorite;
  FavoriteScreen({this.selectedFavorite});

  @override
  State <FavoriteScreen> createState() => _FavoriteScreenState();


}

 class _FavoriteScreenState extends State<FavoriteScreen>{

   User firebaseUser = FirebaseAuth.instance.currentUser;
   QuerySnapshot<Map<String, dynamic>> FavoriteList;
   DocumentSnapshot<Map<String, dynamic>> docData;
   CollectionReference usersRef =  FirebaseFirestore.instance.collection('favorites');// for printing
   var username; // for display to user
   var useremail;
   getUserData(String uid) async {

     //اجيب بيانات دوكيمنت واحد فقط
     //get will return docs Query snapshot
     await FirebaseFirestore.instance.collection('users').doc(uid).get().then((userDocu) async{
       //value.data is the full fields for this doc

       if (userDocu.exists) {
         setState(() {
           docData = userDocu.data() as DocumentSnapshot<Map<String, dynamic>>;
           var description  = docData['description '];
           username = docData['username'];
           var image= docData['image'];
           var price = docData['price'];
           var productId= docData['product id'];
           // print(value.id);

         });
       } else {
       }
     });
     fetchSpecifiedProduct();
   }
   Future fetchSpecifiedProduct() async {
     //هذا اللي يجيب ال doc على الابلكيشن
     try {
       await FirebaseFirestore.instance.collection('favorites')
           .where('product id', isEqualTo: widget.selectedFavorite.id)
           .get().then((specifiedDoc) async {
         if (specifiedDoc != null && specifiedDoc.docs.isEmpty == false) {
           setState(() {
             FavoriteList = specifiedDoc;
           });
         } else {
           print('No Docs Found');
         }
       });
     } catch (e) {
       print('Error Fetching Data$e');
     }
   }
   void initState() {
     if (firebaseUser != null && firebaseUser.uid != null){
       getUserData(firebaseUser.uid);

     }
     fetchSpecifiedProduct();
     super.initState();
   }
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         iconTheme: IconThemeData(color: black),
         elevation: 0,
         leading: IconButton(
           icon: Icon(Icons.arrow_back_ios),
           onPressed: () {
             //Navigator.of(context).pop();
             Get.back();
           },
           color: black,
         ),
         title: Padding(
           padding: EdgeInsets.only(top: 1),
           child: Text(
             "${widget.selectedFavorite.data()['product name'].toString()}'s Products",
             style: TextStyle(
               color: black,
               fontWeight: FontWeight.bold,
               fontSize: 20,
             ),
           ),
         ),
         backgroundColor: basicColor,
         toolbarHeight: 80,
       ),
       endDrawer: MainDrawer(
         username: username,
         useremail: useremail,
       ),
       backgroundColor: basicColor,
       body: ListView(children: <Widget>[
         SizedBox(
           height: 20,
         ), //between them
         FavoriteFlowList(context),
       ]),
     );
   }
   Widget FavoriteFlowList(BuildContext context){
     if (FavoriteList != null) {
       return Container(
         height: MediaQuery.of(context).size.height - 180,
         decoration: BoxDecoration(
             color: white,
             borderRadius: BorderRadius.only(
               topLeft: Radius.circular(100),
               //bottomRight: Radius.circular(90),
             )),
         child: ListView(
           primary: false,
           physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
           padding: EdgeInsets.only(left: 25, right: 25),
           children: <Widget>[
             Padding(
                 padding: EdgeInsets.only(top: 45),
                 child: Container(
                   height: MediaQuery.of(context).size.height - 300,
                   child: FavoriteList.docs.isEmpty ? Center(
                     child: Text("no elements",style: TextStyle(color: black),),
                   )
                       : ListView.separated(
                     itemCount: FavoriteList.docs.length,
                     separatorBuilder: (context, i) => Padding(
                       padding: const EdgeInsets.all(12.0),
                       child: Container(
                         height: 3,
                         color: basicColor,
                       ),
                     ),
                     itemBuilder: (context, i) {
                       return InkWell(
                         onTap: (){},
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: <Widget>[
                             Container(
                               child: Row(
                                 children: <Widget>[
                                   Hero(
                                       tag: FavoriteList.docs[i].data()['product id'].toString(),
                                       child:
                                       FavoriteList.docs[i].data()['image'].toString() != null ?
                                       Image.network(FavoriteList.docs[i].data()['image'].toString(),
                                         fit: BoxFit.cover,
                                         height: 75,
                                         width: 75,
                                       ):
                                       Image.network("https://thumbs.dreamstime.com/b/product-icon-collection-trendy-modern-flat-linear-vector-white-background-thin-line-outline-illustration-130947207.jpg",
                                         fit: BoxFit.cover,
                                         height: 75,
                                         width: 75,
                                       ) ),

                                   SizedBox(width: 10,),
                                   Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: <Widget>[

                                       Text(FavoriteList.docs[i].data()['product name'].toString()
                                           ??"none",style: TextStyle(color:black,fontSize: 17,fontWeight: FontWeight.bold),),
                                       SizedBox(height: 5,),
                                       // Text(productsList.docs[i].id),

                                       Container(
                                           width: 200,
                                           child:
                                           Text(FavoriteList.docs[i].data()['product description'].toString()??"none",
                                             softWrap: true,
                                             overflow: TextOverflow.fade,
                                             style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,color: grey),)
                                       ),
                                     ],
                                   )
                                 ],
                               ),
                             ),

                           ],
                         ),
                       );

                     },
                   ),
                 ))
           ],
         ),
       );
     }}
}
