import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/pages/product_details.dart';
import 'package:get/get.dart';


class LatestProducts extends StatefulWidget {
  const LatestProducts({Key key}) : super(key: key);

  @override
  _LatestProductsState createState() => _LatestProductsState();
}

class _LatestProductsState extends State<LatestProducts> {
  User firebaseUser = FirebaseAuth.instance.currentUser;
  // DocumentSnapshot <Map<String, dynamic>> familyStore;
  QuerySnapshot<Map<String, dynamic>> productsList;
  //دي اللسته المخزنه فيها الاشياء اللي ف الفيربيس
  DocumentSnapshot<Map<String, dynamic>> docData; // for printing
  String username; // for display to user
  String useremail;
   String userID ;

  getUserData(String uid) async {
    //اجيب بيانات دوكيمنت واحد فقط
    //get will return docs Query snapshot
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) async{
      //value.data is the full fields for this doc
      if (value.exists) {
        setState(() {
          docData = value;
          userID = docData['uid'];
          useremail = docData['email'];
          username = docData['username'];
          // print(value.id);
        });
        print(docData['uid']);
        print(docData['username']);
        print(docData['email']);
        // print(docData['first name']);
        print('======================');
      } else {
      }
    });
    try {
      await FirebaseFirestore.instance.collection('products')
          .where('uid',isNotEqualTo: userID)
          //.orderBy('addedAt',descending: true)
          .get().then((specifiedDoc) async {
        if (specifiedDoc != null && specifiedDoc.docs.isEmpty == false) {
          setState(() {

            productsList = specifiedDoc;





          });

        } else {
          print('No Docs Found');
        }
      });
    } catch (e) {
      print('Error Fetching Data::$e');
    }
  }
  Future fetchSpecifiedProduct() async {

    //هذا اللي يجيب ال doc على الابلكيشن
    try {
      await FirebaseFirestore.instance.collection('products')
    // .where('uid', isNotEqualTo: firebaseUser.uid)
      .orderBy('addedAt',descending: true)
          .get().then((specifiedDoc) async {
        if (specifiedDoc != null && specifiedDoc.docs.isEmpty == false) {
          setState(() {
            productsList = specifiedDoc;
          });
          // await FirebaseFirestore.instance.collection('familiesStores')
          //     .where('family id',isEqualTo: productsList.docs[0].data()['family store id']).get().then((doc){

          
        } else {
          print('No Docs Found');
        }
          });
    } catch (e) {
      print('Error Fetching Data$e');
    }
    //}
//print( " hereeree ${productsList.docs[1].data()}");
    // يطبع كل منتج ف لازم يكون الانديس هو i

  }
  @override
  void initState() {
    if(firebaseUser != null){
      getUserData(firebaseUser.uid);
    }
    else {
      fetchSpecifiedProduct();
    }
super.initState();
  }



  @override
  Widget build(BuildContext context) {
    if( productsList != null ){
    return
        GridView.builder(
     // physics:NeverScrollableScrollPhysics() ,

          itemCount:
          productsList.docs.length > 5 ? 6: 3,
         //scrollDirection: Axis.vertical,
          shrinkWrap: true,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int i) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child:productsList.docs.isEmpty ? CircularProgressIndicator():
              Single_prod(
                id: productsList.docs[i].data()['product id'],
                product_name:productsList.docs[i].data()['product name'],
                product_picture: productsList.docs[i].data()['image product'],
               // product_owner: product_list[index]['owner name'],
                product_category: productsList.docs[i].data()['category name'],
                product_price: productsList.docs[i].data()['price'],
                selectedPro: productsList.docs[i],
              ),
            );
          }

    );
    }
    // else if(firebaseUser != null && latestProducts != null){
    //   return GridView.builder(
    //     gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    //     shrinkWrap: true,
    //      itemCount:latestProducts.docs.length >3? 5:2,
    //      itemBuilder:(BuildContext context, int i) {
    // return Padding(
    // padding: const EdgeInsets.all(8.0),
    // child:latestProducts.docs.isEmpty ? CircularProgressIndicator():
    // Single_prod(
    //   id: latestProducts.docs[i].data()['product id'],
    //   product_name:latestProducts.docs[i].data()['product name'],
    //   product_picture: latestProducts.docs[i].data()['image product'],
    //   product_category: latestProducts.docs[i].data()['category name'],
    //   product_price: latestProducts.docs[i].data()['price'],
    //   selectedPro: latestProducts.docs[i], )
    // );});}
    else{
      return Container(child: Center(child: CircularProgressIndicator()));
    }
  }
}

class Single_prod extends StatelessWidget {
  final id;
  final product_name;
  final product_picture;
  final product_owner;
  final product_category;
  final product_price;
  final DocumentSnapshot<Map<String, dynamic>>  selectedPro ;

  Single_prod(

      {
        this.id,
        this.product_name,
      this.product_picture,
        this.product_owner,
      this.product_category,
      this.product_price, this.selectedPro});

  @override
  Widget build(BuildContext context) {
    //Size s = MediaQuery.of(context).size;
    return  Card(


        child: Hero(
          //كان في جوا التاق (product_name)  غيرتو عشان كان في مالتبيل هيروز
          tag: id,
          child: Material(

            child: InkWell(
                  //when onTap on specific context
                onTap: () {
                  Get.to(()=> ProductDetails(selectedProduct:
                  selectedPro));

                },

                child: GridTile(
                  footer: Container(
                    height:90,
                    color: Colors.white30,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(product_name,
                                softWrap:product_name.toString().length>5? true: false,
                                maxLines: 2,

                                style: TextStyle(fontWeight: FontWeight.bold,color:black,fontSize: 15)),

                                Text(
                                    "category: ${product_category}",
                                    //ربا هنا قبل التيكست ستايل كان في const شلتها لانو اللون مارضي يتغير الا هنا
                                    style: TextStyle(
                                         fontWeight: FontWeight.w800, fontSize: 13,color:black,),
                                  ),
                        Text(
                            "SR $product_price",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.w500 ,fontSize: 12),
                          ),



                          ],
                        ),
                      ),
                    ),
                  ),
                  child: Image.network(product_picture, fit: BoxFit.cover,),
                )),
          ),
        ),

    );
  }
}
