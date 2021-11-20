import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/pages/cart_details.dart';
import 'package:my_product/pages/product_details.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
  var productId;
}

class _CartScreenState extends State<CartScreen> {

  var firebaseUser = FirebaseAuth.instance.currentUser;

  QuerySnapshot<Map<String, dynamic>> cartList;
  var docData;
  var description;
  var username; // for display to user
  var useremail;
  var productId;
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
            for (int i = 0; i < cartList.docs.length; i++) {
              productId = cartList.docs[i].data()['product id'];
              double price = cartList.docs[i].data()['price'];

              totalPrice= (totalPrice + price);
              totalPrice.toString();
              return totalPrice;
            }
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
        body: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                height: MediaQuery.of(context).size.height - 100,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(120),
                    )),
                child: ListView.separated(
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          Get.to(() =>
                              ProductDetails(
                                selectedProduct: cartList.docs[i],));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(

                              child: Row(
                                  children: <Widget>[
                                    Hero(
                                        tag: cartList.docs[i].id,
                                        child:
                                        cartList.docs[i].data()['image']
                                            .toString() != null ?
                                        Image.network(
                                          cartList.docs[i].data()['image']
                                              .toString(),
                                          fit: BoxFit.cover,
                                          height: 75,
                                          width: 75,
                                        ) :
                                        Image.network(
                                          "https://thumbs.dreamstime.com/b/product-icon-collection-trendy-modern-flat-linear-vector-white-background-thin-line-outline-illustration-130947207.jpg",
                                          fit: BoxFit.cover,
                                          height: 70,
                                          width: 70,
                                        )),

                                    SizedBox(width: 10,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
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

                                        Container(
                                            width: 200,
                                            child:
                                            Text(cartList.docs[i]
                                                .data()['description']
                                                .toString() ?? "none",
                                              softWrap: true,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                  color: black),)
                                        ),
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
                                        ] ),
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
                        color: basicColor,
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
                    MaterialButton(
                      color: basicColor,

                      onPressed: (){
                        Navigator.push(context,
                                     MaterialPageRoute(builder: (context) =>
                            CartDetails(),
                                     ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Go to the payment stage"),
                          Icon(Icons.label),
                        ],),),

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
