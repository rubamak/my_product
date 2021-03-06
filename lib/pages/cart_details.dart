import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:my_product/color/my_colors.dart';

import 'home_page.dart';


class CartDetails extends StatefulWidget {

  @override
  State<CartDetails> createState() => _CartDetails();
}

class _CartDetails extends State<CartDetails> {

  var firebaseUser = FirebaseAuth.instance.currentUser;
  CollectionReference cartRef = FirebaseFirestore.instance.collection('cart');

  QuerySnapshot<Map<String, dynamic>> cartList;
  var productId;
  double newTotalPrice;


  Future cartCompleted ()async{
    FocusScope.of(context).unfocus();

    try{
      final snackBar = SnackBar
        (duration: Duration(seconds: 2), content: Text("completed ",
        style: TextStyle(color: white, fontSize: 15),), backgroundColor: black,);
      // updateProduct();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Get.off(()=> HomePage());
      cartRef.doc(firebaseUser.uid).delete();
      setState(() {
      });
    }catch(e){
      print("Error:$e");
      setState(() {});
    }}
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
      await FirebaseFirestore.instance.collection('cart').
      doc(firebaseUser.uid).collection('cart_products_user')
          .get().then((doc) async {
        if (doc != null && doc.docs.isEmpty == false) {
            cartList = doc;
            double price;
            double totalPrice = 0.0;
            if (doc != null && doc.docs.isEmpty == false) {
                cartList = doc;
                for (int i = 0; i < cartList.docs.length; i++) {
                  productId = cartList.docs[i].data()['product id'];
                  price = cartList.docs[i].data()['price'];
                  totalPrice= totalPrice+ price;
                  totalPrice.toString();
                }
            }
            setState(() {
              newTotalPrice = totalPrice;
            });
             print(totalPrice);
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

      return Scaffold(
        backgroundColor: basicColor,
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: black),
          toolbarHeight: 80,
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(top: 1),
            child: Text(
              "Cart Coast",
              style: TextStyle(color: black, fontSize: 25),
            ),
          ),
          backgroundColor: basicColor,

        ),
        body: cartList != null?
        Container(
            height: MediaQuery.of(context).size.height - 150,
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(120),
                )),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Expanded(
                flex: 5,

                  child: ListView.separated(
                      itemBuilder: (context, i) {
                        return Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Row(
                                    children: <Widget>[

                                      SizedBox(width: 80,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          SizedBox(height: 15,),

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
                                      //
                                    ] ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, i) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 12),
                        child: Container(
                          height: 3,
                          color: grey,
                        ),
                      ),
                      itemCount: cartList.docs.length),
                  //it was here
                ),


            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: ListView(
                  children: [
                    MaterialButton(
                      color: basicColor,

                      onPressed: (){
                        // cartCompleted();
                        setState(() {

                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("total price : ${newTotalPrice}RS"),
                        ],),),
                  ],
                ),
                ),
              ),
          ],
        ),
        ):  Container(
          height: MediaQuery.of(context).size.height - 150,
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(100),
                //bottomRight:Radius.circular(150),
              )),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center, children: const [
            Center(child:Text(("No products in cart"))),
            SizedBox(
              height: 100,
            )]),
        ),);



  }

}
