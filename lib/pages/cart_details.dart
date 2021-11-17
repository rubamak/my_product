import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/pages/product_details.dart';

class cartDetails extends StatefulWidget {
  @override
  State<cartDetails> createState() => _cartDetails();
  var productId;
}

class _cartDetails extends State<cartDetails> {

  var firebaseUser = FirebaseAuth.instance.currentUser;

  QuerySnapshot<Map<String, dynamic>> cartList;

  var docData;
  var description;
  var username; // for display to user
  var useremail;
  var productId;
  double price;
  double totalPrice = 0.0;

  getCart() async {
    await FirebaseFirestore.instance.collection('cart').
    doc(firebaseUser.uid).collection('cart_products_user')
        .get().then((doc) async {
      //value.data is the full fields for this doc

      if (doc != null && doc.docs.isEmpty == false) {
        setState(() {
          cartList = doc;
          // print(value.id);

        });
      } else {}
    });
    userTotalPrice();
  }
  Future userTotalPrice() async {
    try {
      await FirebaseFirestore.instance
          .collection('cart')
          .get()
          .then((specifiedDoc) async {
        if (specifiedDoc != null && specifiedDoc.docs.isEmpty == false) {
          setState(() {
            cartList = specifiedDoc;
            var list = [];
             for (int i = 0; i < cartList.docs.length; i++) {
               var item;
               list.add(Container(
                   child: FittedBox(
                     fit: BoxFit.fitWidth,
                     child: Text(
                       item[i],
                     ),
                   )));

            //   productId = cartList.docs[i].data()['product id'];
            //   price = cartList.docs[i].data()['price'];
            //
            //   totalPrice.toString();
            //   print(totalPrice) ;
            }
             return list;
          });
        } else {
          print('No product Found');
        }
      });
    } catch (e) {print('Error Fetching Data$e');}}
  void initState() {
    if (firebaseUser != null) {getCart();}
    print(cartList);
    super.initState();}

  @override
  Widget build(BuildContext context) {
    if (cartList != null) {
      return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          toolbarHeight: 70,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: black),
            onPressed: () => Get.back,
          ),
          title: Padding(
            padding: EdgeInsets.only(top: 1),
            child: Text(
              "cart",
              style: TextStyle(color: black, fontSize: 25),
            ),
          ),
          backgroundColor: basicColor,
        ),
        body: new Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100,),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height - 100,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(120),
                    )),
                child: ListView.separated(
                    itemBuilder: (context, i) {
                      return Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Row(
                                  children: <Widget>[

                                    SizedBox(width: 10,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: <Widget>[

                                        Text(cartList.docs[i]
                                            .data()['product name'].toString()
                                            ?? "none", style: TextStyle(
                                            color: black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),),
                                        SizedBox(height: 5,),

                                        Text("${cartList.docs[i].data()['price']
                                            .toString()} SR" ?? "none",
                                          softWrap: true,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: black),)
                                        ,
                                      ],



                                    ),

                                    SizedBox(width: 10,),

                                    Column(  mainAxisAlignment: MainAxisAlignment
                                        .center,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: <Widget>[

                                          ],
                                      ),
                                  ] ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 3,
                        color: grey,
                      ),
                    ),
                    itemCount: cartList.docs.length),
                //it was here
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: ListView(
                  children: [
                    Text("your total pricr is $totalPrice ",
                    style: TextStyle(color: black , fontSize: 30, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            iconTheme: IconThemeData(color: black),
            toolbarHeight: 100,
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: black),
            ),
            title: Padding(
              padding: EdgeInsets.only(top: 1),
              child: Text(
                "Add products to cart",
                style: TextStyle(color: black, fontSize: 25),
              ),
            ),
            backgroundColor: basicColor,
          ),
          body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("No products in cart"),
            SizedBox(
              height: 100,
            ),


            SizedBox(height: 15),
          ]));
    }
  }

}
