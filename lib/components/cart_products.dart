

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:like_button/like_button.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/modules/product.dart';
import 'package:my_product/pages/product_details.dart';


class CartScreen extends StatefulWidget {
  static const routeName = '/Cart-screen';

  @override
  State <CartScreen> createState() => _CartScreenState();


}

class _CartScreenState extends State<CartScreen>{

  User firebaseUser = FirebaseAuth.instance.currentUser;
  QuerySnapshot<Map<String, dynamic>> cartList;
  var docData;
  var description;
  var username; // for display to user
  var useremail;

  // var productId;
  getCart() async {

    await FirebaseFirestore.instance.collection('cart').
    doc(firebaseUser.uid).collection('cart_products_user')
        .get().then((doc) async{
      //value.data is the full fields for this doc

      if (doc != null && doc.docs.isEmpty == false) {
        setState(() {
          cartList= doc;
          // print(value.id);

        });
      } else {
      }
    });
  }

  void initState() {
    if (firebaseUser != null ){
      getCart();

    }
    print(cartList);
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: //between them
      /////bbfbfhfh
      CartFlowList(context),
    );
  }
  Widget CartFlowList(BuildContext context){
    if (cartList != null) {
      return
        Container(
            height: MediaQuery.of(context).size.height - 200,
            color: white,

          child: ListView(
              primary: false,
              physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              padding: EdgeInsets.only(left: 25, right: 25),
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 300,
                      child: cartList.docs.isEmpty ? Center(
                        child: Text("no elements",style: TextStyle(color: black),),
                      )
                          : ListView.separated(
                        itemCount: cartList.docs.length,
                        separatorBuilder: (context, i) => Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            height: 3,
                            color: basicColor,
                          ),
                        ),
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: (){
                             Get.to(()=> ProductDetails(selectedProduct: cartList.docs[i],));
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
                                          cartList.docs[i].data()['image'].toString() != null ?
                                          Image.network(cartList.docs[i].data()['image'].toString(),
                                            fit: BoxFit.cover,
                                            height: 75,
                                            width: 75,
                                          ):
                                          Image.network("https://thumbs.dreamstime.com/b/product-icon-collection-trendy-modern-flat-linear-vector-white-background-thin-line-outline-illustration-130947207.jpg",
                                            fit: BoxFit.cover,
                                            height: 70,
                                            width: 70,
                                          ) ),

                                      SizedBox(width: 10,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[

                                          Text(cartList.docs[i].data()['product name'].toString()
                                              ??"none",style: TextStyle(color:black,fontSize: 20,fontWeight: FontWeight.bold),),
                                          SizedBox(height: 5,),
                                          // Text(productsList.docs[i].id),

                                          Container(
                                              width: 200,
                                              child:
                                              Text(cartList.docs[i].data()['description'].toString()??"none",
                                                softWrap: true,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal,color: black),)
                                          ),
                                          Text("${cartList.docs[i].data()['price'].toString()} SR" ?? "none",
                                            softWrap: true,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: black),)
                                        ],
                                      ),

                                    ],

                                  ),
                                ),

                              ],
                            ),
                          );

                        },
                      ),
                    ))


                // SizedBox(height: 20,),
                // Container(
                //   height: MediaQuery.of(context).size.height - 180,
                //   decoration: BoxDecoration(
                //       color: white,
                //       borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(100),
                //         bottomRight: Radius.circular(90),
                //       )),
                //   // height: MediaQuery.of(context).size.height - 300,
                //   child: cartList.docs.isEmpty ? Center(
                //     child: Text("no elements",style: TextStyle(color: black),),
                //   )
                //       : ListView.separated(
                //     itemCount: cartList.docs.length,
                //     separatorBuilder: (context, i) => Padding(
                //       padding: const EdgeInsets.all(12.0),
                //       child: Container(
                //         height: MediaQuery.of(context).size.height - 180,
                //         decoration: BoxDecoration(
                //             color: white,
                //             borderRadius: BorderRadius.only(
                //               topLeft: Radius.circular(100),
                //               bottomRight: Radius.circular(90),
                //             )),
                //         color: basicColor,
                //       ),
                //     ),
                //     itemBuilder: (context, i) {
                //       return InkWell(
                //         onTap: (){},
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //           children: <Widget>[
                //             Container(
                //
                //               child: Row(
                //
                //                 children: <Widget>[
                //                   Hero(
                //                       tag: cartList.docs[i].id,
                //                       child:
                //                       cartList.docs[i].data()['image'].toString() != null ?
                //                       Image.network(cartList.docs[i].data()['image'].toString(),
                //                         fit: BoxFit.cover,
                //                         height: 75,
                //                         width: 75,
                //                       ):
                //                       Image.network("https://thumbs.dreamstime.com/b/product-icon-collection-trendy-modern-flat-linear-vector-white-background-thin-line-outline-illustration-130947207.jpg",
                //                         fit: BoxFit.cover,
                //                         height: 70,
                //                         width: 70,
                //                       ) ),
                //
                //                   SizedBox(width: 10,),
                //                   Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     children: <Widget>[
                //
                //                       Text(cartList.docs[i].data()['product name'].toString()
                //                           ??"none",style: TextStyle(color:black,fontSize: 20,fontWeight: FontWeight.bold),),
                //                       SizedBox(height: 5,),
                //                       // Text(productsList.docs[i].id),
                //
                //                       Container(
                //                           width: 200,
                //                           child:
                //                           Text(cartList.docs[i].data()['description'].toString()??"none",
                //                             softWrap: true,
                //                             overflow: TextOverflow.fade,
                //                             style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal,color: black),)
                //                       ),
                //                       Text("${cartList.docs[i].data()['price'].toString()} SR" ?? "none",
                //                         softWrap: true,
                //                         overflow: TextOverflow.fade,
                //                         style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: black),)
                //                     ],
                //                   ),
                //
                //                 ],
                //
                //               ),
                //             ),
                //
                //           ],
                //         ),
                //       );
                //
                //     },
                //   ),
                // )
              ],

          ),
        );
    }else{
      return Container(
        // height: MediaQuery.of(context).size.height - 180,
        // decoration: BoxDecoration(
        // color: white,
        // borderRadius: BorderRadius.only(
        // topLeft: Radius.circular(100),
        // //bottomRight: Radius.circular(90),
        // )),
        child: Center(child: Text("no products in Cart "),),);
    }
  }
}


























//
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/widgets.dart';
// import 'package:my_product/color/my_colors.dart';
// import 'package:my_product/pages/single_chat_screen.dart';
//
// class Cart_products extends StatefulWidget {
//   const Cart_products({Key key}) : super(key: key);
//
//   @override
//   _Cart_productsState createState() => _Cart_productsState();
// }
//
// class _Cart_productsState extends State<Cart_products> {
//
//  var Products_on_the_cart = [
//  {
//  "name": "Fatah",
//  "picture": "images/products/f.png",
//  "owner name": "Happy making",
//  "category": "Food",
//  "price": 20,
//  "quantity": 1,
//  },
//  {
//  "name": "Painted Cup",
//  "picture": "images/products/hand.jpg",
//  "owner name": "Happy making 2 ",
//  "category": "Handmade",
//  "price": 18,
//  "quantity": 2,
//   },
//  ];
//   @override
//   Widget build(BuildContext context) {
//     return new ListView.builder(
//       itemCount: Products_on_the_cart.length,
//       itemBuilder: (context, index){
//         return Single_cart_products(
//           cart_product_name: Products_on_the_cart[index]["name"],
//           cart_product_category: Products_on_the_cart[index]["category"],
//           cart_product_owner: Products_on_the_cart[index]["owner name"],
//           cart_product_picture: Products_on_the_cart[index]["picture"],
//           cart_product_price: Products_on_the_cart[index]["price"],
//           cart_product_quantity: Products_on_the_cart[index]["quantity"],
//         );
//       }
//
//     );
//   }
// }
// class Single_cart_products extends StatelessWidget {
//    final  cart_product_name;
//    final cart_product_picture;
//    final cart_product_owner;
//    final cart_product_category;
//    final cart_product_price;
//    final  cart_product_quantity;
//
//   Single_cart_products({
//     this.cart_product_name,
//     this.cart_product_picture,
//     this.cart_product_owner,
//     this.cart_product_category,
//     this.cart_product_price,
//     this.cart_product_quantity,
// });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         //leading section for an image
//         leading: new Image.asset(
//           cart_product_picture,width: 30, height: 50,),
//
//         // title section
//         title: new Text(cart_product_name,style: TextStyle(fontWeight: FontWeight.w600, color:black),),
//         // subtitle section
//         subtitle: new Column(
//           children: <Widget>[
//             //row inside column
//             new Row(
//               children: <Widget>[
//
//                 //this is for quantity of product
//                 Padding(
//                   padding: const EdgeInsets.all(3.0),
//                   child: new Text('Quantity: ',style:TextStyle(color:black)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(3.0),
//                   child: new Text('$cart_product_quantity',style: TextStyle(color:black)),
//                 ),
//
//                 // ===this is for owner of the product===
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(20, 10, 8,8),
//                   child: new Text('Owner:',style: TextStyle(color:black),),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(6.0),
//                   child: new Text(cart_product_owner,style: TextStyle(color:black),),
//                 ),
//                 new IconButton(
//                   onPressed: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context) {}
//                     //    SingleChatScreen()
//                     ));
//                   },
//                   icon: Icon(Icons.chat_outlined,color: black,),),
//
//               ],
//             ),
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
