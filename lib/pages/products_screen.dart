import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/dummy_data.dart';
import 'package:my_product/widgets/main_drawer.dart';
import 'package:my_product/widgets/product_item.dart';
import 'package:get/get.dart';

import 'families_screen.dart';

class ProductsScreen extends StatefulWidget {
  static const routeName = '/theProducts-screen';
  final DocumentSnapshot<Map<String, dynamic>> selectedFamilyStore;
  ProductsScreen({this.selectedFamilyStore});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  User firebaseUser = FirebaseAuth.instance.currentUser;
 // DocumentSnapshot <Map<String, dynamic>> familyStore;
  QuerySnapshot<Map<String, dynamic>> productsList;
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
    fetchSpecifiedProduct();
  }

  Future fetchSpecifiedProduct() async {
    // if(firebaseUser != null && firebaseUser.uid != null){
    //   try {
    //     await FirebaseFirestore.instance.collection('products')
    //         .where('family store id', isEqualTo: widget.selectedFamilyStore.id)
    //         //.where('uid', isNotEqualTo: docData.id)
    //         .get().then((specifiedDoc) async {
    //       if (specifiedDoc != null && specifiedDoc.docs.isEmpty == false) {
    //         setState(() {
    //           productsList = specifiedDoc;
    //         });
    //       } else {
    //         print('No Docs Found');
    //       }
    //     });
    //   } catch (e) {
    //     print('Error Fetching Data$e');
    //   }
    //
    // }else{
      try {
        await FirebaseFirestore.instance.collection('products')
            .where('family store id', isEqualTo: widget.selectedFamilyStore.id)
            //.where('uid', isNotEqualTo: docData.id)
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
        print('Error Fetching Data$e');
      }
    //}
//print( " hereeree ${productsList.docs[1].data()}");
    // يطبع كل منتج ف لازم يكون الانديس هو i

  }

  @override
  void initState() {
    if (firebaseUser != null && firebaseUser.uid != null){
      getUserData(firebaseUser.uid);
    }
    fetchSpecifiedProduct();
    super.initState();
  }

  @override
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
            "${widget.selectedFamilyStore.data()['family store name'].toString()}  Products",
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
        productFlowList(context),
      ]),
    );
  }
  Widget productFlowList(BuildContext context){
    if (productsList != null) {
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
                  child: productsList.docs.isEmpty
                      ? Center(
                    child: Text("no elements",style: TextStyle(color: black),),
                  )
                      : ListView.separated(
                    itemCount: productsList.docs.length,
                    separatorBuilder: (context, i) => Container(
                      height: 1,
                      color: grey,
                    ),
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: (){
                          //Get.to(()=> ProductsScreen(selectedFamilyStore: familiesStoresList.docs[i],));
                          //ProductsScreen(selectedFamilyStore: ,));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Hero(
                                      tag: productsList.docs[i].data()['product id'].toString(),
                                      child:
                                      productsList.docs[i].data()['image product'].toString() != null ?
                                      Image.network(productsList.docs[i].data()['image product'].toString(),
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

                                      Text(productsList.docs[i].data()['product name'].toString()
                                          ??"none",style: TextStyle(color:black,fontSize: 17,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 5,),

                                      Container(
                                          width: 200,
                                          child:
                                          Text(productsList.docs[i].data()['product description'].toString()??"none",
                                            softWrap: true,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(fontSize: 17,fontWeight: FontWeight.normal,color: grey),)
                                      ),
                                      Text("${productsList.docs[i].data()['category name'].toString()} Store" ??"none",
                                        style: TextStyle(color:black),),
                                    ],
                                  )
                                ],
                              ),
                            ),

                            firebaseUser!= null? IconButton(
                              onPressed: (){},//chatWithFamily(context),
                              // Navigator.of(context).pushNamed(ChatScreen.routeName);
                              icon: Icon(Icons.chat_outlined,color: black,),
                              color: black,
                            ): SizedBox(width: 1,),
                          ],
                        ),
                      );

                    },
                  ),
                ))
          ],
        ),
      );
    } else  {
      return Container(
          height: MediaQuery.of(context).size.height - 180,
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100),
                bottomRight: Radius.circular(150),
              )),
          child: Center(child: CircularProgressIndicator()));
    }


  }
  // Widget build(BuildContext context) {
  //   final routeArg = ModalRoute.of(context).settings.arguments as Map<String, Object>;
  //   final familyId = routeArg['id'];
  //   final familyName = routeArg['name'];
  //
  //   final products = DUMMY_PRODUCTS;
  //   //     .where((product) {
  //   //   return product.familyId == familyId;
  //   // }).toList();
  //
  //   return Scaffold(
  //     appBar: AppBar(
  //       iconTheme: IconThemeData(color: black),
  //       elevation: 0,
  //       leading: IconButton(
  //         icon: Icon(Icons.arrow_back_ios),
  //         onPressed: () {
  //           Navigator.of(context).pop(familyName);
  //         },
  //         color: white,
  //       ),
  //       title: Padding(
  //         padding: EdgeInsets.only(top: 1),
  //         child: Text(
  //           "Products of ${familyName.toString()}",
  //           style: TextStyle(
  //             color: black,
  //             fontWeight: FontWeight.bold,
  //             fontSize: 23,
  //           ),
  //         ),
  //       ),
  //       backgroundColor: basicColor,
  //       toolbarHeight: 80,
  //     ),
  //     //endDrawer: MainDrawer(),
  //     backgroundColor: basicColor,
  //     body:
  //     ListView(children: <Widget>[
  //       SizedBox(
  //         height: 20,
  //       ), //between them
  //       Container(
  //         height: MediaQuery.of(context).size.height - 180,
  //         decoration: BoxDecoration(
  //             color: white,
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(100),
  //               //bottomRight:Radius.circular(150)
  //             )),
  //         child: ListView(
  //           primary: false,
  //           padding: EdgeInsets.only(left: 25, right: 25),
  //           children: <Widget>[
  //             Padding(
  //               padding: EdgeInsets.only(top: 45),
  //               child: Container(
  //                 height: MediaQuery.of(context).size.height - 300,
  //                 child: ListView(
  //                   children: [
  //                     Center(child: CircularProgressIndicator(),),
  //                   ],
  //                   // children: products
  //                   //     .map((productItem) => ProductItem(
  //                   //         productId: productItem.productId,
  //                   //         productName: productItem.productName,
  //                   //         productImage: productItem.productImage,
  //                   //         price: productItem.price,
  //                   //         description: productItem.description))
  //                   //     .toList(),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       )
  //     ]),
  //   );
  // }
}
