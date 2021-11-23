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
  var username; // for display to user
  var useremail;

  getUserData(String uid) async {
    //اجيب بيانات دوكيمنت واحد فقط
    //get will return docs Query snapshot
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) async{
      //value.data is the full fields for this doc
      if (value.exists) {
        setState(() {
          docData = value;
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
          .where('uid', isNotEqualTo: docData.id)
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
    //fetchSpecifiedProduct();
  }
  Future fetchSpecifiedProduct() async {

    //هذا اللي يجيب ال doc على الابلكيشن
    try {
      await FirebaseFirestore.instance.collection('products')
      .orderBy('addedAt',descending: true)
      //.where('uid', isNotEqualTo: firebaseUser.uid)
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
fetchSpecifiedProduct();
super.initState();
  }



  // var product_list = [
  //   {
  //     "name": "Fatah",
  //     "picture": "images/products/f.png",
  //     "owner name": "Happy making",
  //     "category": "Food",
  //     "price": 20,
  //   },
  //   {
  //     "name": "Painted Cup",
  //     "picture": "images/products/hand.jpg",
  //     "owner name": "Happy making 2 ",
  //     "category": "Handmade",
  //     "price": 18,
  //   },
  //   {
  //     "name": "Frappe",
  //     "picture": "images/products/ice.jpg",
  //     "owner name": "Happy making 3",
  //     "category": "Beverages",
  //     "price": 15,
  //   },
  //   {
  //     "name": "Waffle",
  //     "picture": "images/products/waff.png",
  //     "owner name": "Happy making",
  //     "category": "Food",
  //     "price": 18,
  //   },
  //   {
  //     "name": "Waffle",
  //     "picture": "images/products/waff.png",
  //     "owner name": "Happy making",
  //     "category": "Food",
  //     "price": 18,
  //   },
  //
  //
  // ];

  @override
  Widget build(BuildContext context) {
    return productsList == null ? SizedBox(height: 0,)
        :GridView.builder(
     // physics:NeverScrollableScrollPhysics() ,

          itemCount: productsList.docs.length > 5 ? 6: 3,
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

                          // leading: Text(product_name,
                          //     softWrap:product_name.toString().length>5? true: false,
                          //     maxLines: 2,
                          //
                          //     style: TextStyle(fontWeight: FontWeight.bold,color:black)),
                          // subtitle: Text(
                          //   "SR $product_price",
                          //   textAlign: TextAlign.left,
                          //   style: TextStyle(
                          //       color: black,
                          //       fontWeight: FontWeight.w500 ,fontSize: 15),
                          // ),
                          // title: Text(
                          //   "category: ${product_category}",
                          //   //ربا هنا قبل التيكست ستايل كان في const شلتها لانو اللون مارضي يتغير الا هنا
                          //   style: TextStyle(
                          //        fontWeight: FontWeight.w800, fontSize: 12,color:black,),
                          // ),
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
