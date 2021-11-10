import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:like_button/like_button.dart';
import 'package:my_product/color/my_colors.dart';
import 'dart:io';
import 'dart:ui';
import 'package:my_product/modules/product.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import 'Comment_screen.dart';

class ProductDetails extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> selectedProduct;

  ProductDetails({this.selectedProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  User firebaseUser = FirebaseAuth.instance.currentUser;
  bool isFav;
  bool isInCart;
  QuerySnapshot<Map<String, dynamic>> productInfo;
  String productName;

  String productId;
  String productDescription;
  var price;
  String categoryName;
  String image;

  //QuerySnapshot<Map<String, dynamic>> productsList;
  //DocumentSnapshot<Map<String, dynamic>> docData;

  getProduct() async {
    //اجيب بيانات دوكيمنت واحد فقط
    //get will return docs Query snapshot
    // await FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) async {
    //   //value.data is the full fields for this doc
    //   if (value.exists) {
    //     setState(() {
    //       docData = value;
    //       print(docData.id);
    //     });
    try {
      await FirebaseFirestore.instance
          .collection('products')
      //.where('uid', isNotEqualTo: docData.id)
          .where('product id', isEqualTo: widget.selectedProduct.id.toString())
          .get()
          .then((specifiedDoc) async {
        if (specifiedDoc != null && specifiedDoc.docs.isEmpty == false) {
          setState(() {
            productInfo = specifiedDoc;
            productId = productInfo.docs[0].data()['product id'];
            print(productId);
          });
        } else {
          print('No Docs Found');
        }
      });
    } catch (e) {
      print('Error Fetching Data$e');
    }
  }

  @override
  void initState() {
    getProduct();
    print(" id for product ${widget.selectedProduct.id}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List <Product> prodList =
    //     Provider.of<Products>(context,listen: true).productsList;
    // هذا عنصر واحد
    //     var filteredItem = prodList.firstWhere(
    //             (element) => element.description == desc, orElse: null);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        elevation: 0,
        // leading:  IconButton(
        //   icon: Icon(Icons.arrow_back_ios),
        //   onPressed: () {
        //     Navigator.pop(context,filteredItem.productName);
        //   },
        //   color: Colors.white,
        // ),
        title: Padding(
          padding: EdgeInsets.only(top: 1),
          child: productInfo != null
              ? Text(
            "${productInfo.docs[0].data()['product name'].toString()}'s details",
            style: TextStyle(
              color: black,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          )
              : SizedBox(
            height: 1,
          ),
        ),
        backgroundColor: basicColor,
        toolbarHeight: 80,
      ),
      body: productInfo == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Container(
          color: basicColor,
          child: Container(
              height: MediaQuery.of(context).size.height - 100,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(120),
                  )),
              child: ListView(children: [
                buildContainer(productInfo.docs[0].data()['image product'], productInfo.docs[0].data()['product id'], context),
                SizedBox(
                  height: 5,
                ),
                buildCard(productInfo.docs[0].data()['product name'], productInfo.docs[0].data()['category name'], productInfo.docs[0].data()['family name'],
                    productInfo.docs[0].data()['product description'], productInfo.docs[0].data()['price']),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      firebaseUser != null
                          ? FutureBuilder<dynamic>(
                          future: FirebaseFirestore.instance
                              .collection('favorites')
                              .doc(firebaseUser.uid)
                              .collection('favorites_products_user')
                              .where('product id', isEqualTo: widget.selectedProduct.id)
                              .get()
                              .then((favDoc) {
                            if (favDoc.docs.isNotEmpty) {
                              setState(() {
                                isFav = true;
                              });
                            } else {
                              setState(() {
                                isFav = false;});}
                          }),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              if (isFav == true) {
                                return IconButton(
                                  onPressed: () {
                                    removeProductFromFavorite();
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 35,
                                  ),
                                );
                              } else {
                                return IconButton(
                                    onPressed: () {
                                      addProductToFavorite();
                                    },
                                    icon: Icon(
                                      Icons.favorite_border,
                                      color: Colors.red,
                                      size: 35,
                                    ));
                              }
                            } else if (snapshot.hasError) {
                              return Text(snapshot.error);
                            } else {
                              return Text(" no connection");
                            }
                          })
                          : IconButton(
                          onPressed: () {
                            AwesomeDialog(
                                body: Text("login for adding to favorite feature!"),
                                context: context,
                                btnCancel: IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                customHeader: Icon(
                                  Icons.account_circle_outlined,
                                  size: 70,
                                ))
                              ..show();
                          },
                          icon: Icon(
                            Icons.favorite_outline,
                            color: Colors.red,
                            size: 35,
                          )),

                      firebaseUser != null
                          ? FutureBuilder(
                          future: FirebaseFirestore.instance.collection('cart').doc(firebaseUser.uid)
                              .collection('cart_products_user').
                          where('product id', isEqualTo: widget.selectedProduct.id).get().then((cartDoc){
                            if(cartDoc.docs.isNotEmpty){
                              setState(() {
                                isInCart = true;
                              });
                            }else{
                              setState(() {
                                isInCart = false ;
                              });
                            }

                          }),
                          builder: (context,snapshot){
                            if(!snapshot.hasData){
                              if(isInCart== true){
                                return IconButton(
                                  onPressed: () {
                                    removeProductFromCart();
                                  },
                                  icon: Icon(
                                    Icons.shopping_cart_rounded,
                                    color: Colors.indigoAccent,
                                    size: 35,
                                  ),
                                );
                              }else{
                                return IconButton(
                                  onPressed: () {
                                    addProductToCart();
                                  },
                                  icon: Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Colors.indigoAccent,
                                    size: 35,
                                  ),
                                );


                              }
                            }else{
                              return Text("no connection");
                            }

                          })
                          : IconButton(
                          onPressed: () {
                            AwesomeDialog(
                                body: Text("login for adding to Cart feature  !"),
                                context: context,
                                btnCancel: IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                customHeader: Icon(
                                  Icons.account_circle_outlined,
                                  size: 70,
                                ))
                              ..show();
                          },
                          icon: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.indigoAccent,
                            size: 35,
                          )),
                      firebaseUser != null ? Container(
                          child: IconButton(
                            icon: Icon(Icons.comment,color: grey,) ,
                            onPressed: (){
                              setState(() {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> CommentsPage(productId:widget.selectedProduct.id)));
                              });
                            },
                          )):SizedBox(width: 0,),
                    ],
                  ),
                ),

                //productInfo != null ?
                // Text("${productInfo.docs[0].data()['product name'].toString()} details"):
                //     Text("none")
              ]))),

      //  buildContainer(filteredItem.productImage,filteredItem.description),
    );

    // floatingActionButton: FloatingActionButton(
    //   onPressed: (){
    //     //Provider.of<Products>(context,listen: false).delete(filteredItem.productImage);
    //     //يحذق لي الصفحة ويرجع لورا طبعا ويروح للصفحة الي قبلها ويحذف هناك
    //    // Navigator.pop(context,filteredItem.description);
    //   },
    //   backgroundColor: basicColor,
    //   child: Icon(Icons.delete,color: black,),
    // //),
  }

  Future removeProductFromFavorite() async {
    CollectionReference favoriteRef = await FirebaseFirestore.instance.collection('favorites');

    try {
      favoriteRef.doc(firebaseUser.uid).collection('favorites_products_user').doc(productId).delete().then((value) {
        print(' product to favorite deleted');
        Fluttertoast.showToast(msg: 'product deleted from favorite list', backgroundColor: Colors.red);
      });

    } catch (e) {
      print("error when deleting product to favorites: $e");
    }
  }

  Future addProductToFavorite() async {
    CollectionReference favoriteRef = await FirebaseFirestore.instance.collection('favorites');

    try {
      favoriteRef.doc(firebaseUser.uid).collection('favorites_products_user').doc(productId).set({
        'uid': firebaseUser.uid,
        'product name': productInfo.docs[0].data()['product name'],
        'price': productInfo.docs[0].data()['price'],
        'description': productInfo.docs[0].data()['product description'],
        'categoryName': productInfo.docs[0].data()['category name'],
        'image': productInfo.docs[0].data()['image product'],
        'product id': productId,
      }).then((value) {
        print(' product to favorite added');
        Fluttertoast.showToast(msg: 'product added to favorite list', backgroundColor: Colors.blue);
      });

    } catch (e) {
      print("error when adding product to favorites: $e");
    }
  }
  Future addProductToCart() async {
    CollectionReference cartRef = await FirebaseFirestore.instance.collection('cart');

    try {
      cartRef.doc(firebaseUser.uid).collection('cart_products_user').doc(productId).set({
        'uid': firebaseUser.uid,
        'product name': productInfo.docs[0].data()['product name'],
        'price': productInfo.docs[0].data()['price'],
        'description': productInfo.docs[0].data()['product description'],
        'categoryName': productInfo.docs[0].data()['category name'],
        'image': productInfo.docs[0].data()['image product'],
        'product id': productId,
      }).then((value) {
        print(' product to cart added');
        Fluttertoast.showToast(msg: 'product added to cart ', backgroundColor: Colors.blue);
      });
      // try{
      //   favoriteRef.add({
      //     'uid': firebaseUser.uid,
      //     'product name': productInfo.docs[0].data()['product name'],
      //     'price': productInfo.docs[0].data()['price'],
      //     'description': productInfo.docs[0].data()['product description'],
      //     'categoryName': productInfo.docs[0].data()['category name'],
      //     'image': productInfo.docs[0].data()['image'],
      //     'product id': productInfo.docs[0].data()['product id'],
      //   }).then((value) {
      //     print(' product to fav added');

      // Fluttertoast.showToast(msg: 'product added',);

      //  });
    } catch (e) {
      print("error when adding product to favorites: $e");
    }
  }
  Future removeProductFromCart() async {
    CollectionReference cartRef = await FirebaseFirestore.instance.collection('cart');

    try {
      cartRef.doc(firebaseUser.uid).collection('cart_products_user').doc(productId).delete().then((value) {
        print(' product from cart deleted');
        Fluttertoast.showToast(msg: 'product deleted from cart !', backgroundColor: Colors.red);
      });

    } catch (e) {
      print("error when deleting product to favorites: $e");
    }
  }

  Container buildContainer(String image, String id, BuildContext context) {
    if (productInfo != null) {
      return Container(
        child: Center(
          child: Hero(
            tag: id,
            child: ClipRRect(
              child: Image.network(
                image,
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height - 600,
                width: MediaQuery.of(context).size.width - 200,
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
          child: SizedBox(
            height: 1,
          ));
    }
  }

  Card buildCard(String title, String category, String familyName, String desc, num price) {
    if (productInfo != null) {
      return Card(
        //color: basicColor,
        elevation: 20,
        margin: EdgeInsets.all(15),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "product:  $title",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: black),
              ),
              Divider(
                color: black,
              ),
              Text(
                "desciption: $desc",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: black),
                textAlign: TextAlign.justify,
              ),
              Divider(
                color: black,
              ),
              Text(
                " price: $price SR",
                style: TextStyle(fontSize: 20, color: black, fontWeight: FontWeight.bold),
              ),
              Divider(
                color: black,
              ),
              Text(
                "family owner: $familyName",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: black),
              ),
              Divider(
                color: black,
              ),
              Text(
                "category: $category",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: black),
              ),
              Divider(
                color: black,
              ),
            ],
          ),
        ),
      );
    } else {
      return Card(
          child: SizedBox(
            height: 1,
          ));
    }
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    return !isLiked;
  }
}