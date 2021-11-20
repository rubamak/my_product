
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:like_button/like_button.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/dummy_data.dart';
import 'package:my_product/pages/drawer_section_pages/favorite_screen.dart';
import 'package:my_product/pages/product_details.dart';
import 'package:my_product/widgets/main_drawer.dart';
import 'package:my_product/widgets/product_item.dart';
import 'package:get/get.dart';

import 'families_screen.dart';

class ProductsScreen extends StatefulWidget {
  static const routeName = '/theProducts-screen';
  final DocumentSnapshot<Map<String, dynamic>> selectedFamilyStore;
  final String familyDescription;
  //final String imageStore;

  ProductsScreen({
    this.selectedFamilyStore,
    this.familyDescription
    //,this.imageStore
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  User firebaseUser = FirebaseAuth.instance.currentUser;

  // DocumentSnapshot <Map<String, dynamic>> familyStore;
  QuerySnapshot<Map<String, dynamic>> productsList;

  String productName;
  String familyId;
  String productId;
  String productDescription;
  var price;
  String categoryName;
  String image;

  //var productId;
  // var description;
  //var price;
  //دي اللسته المخزنه فيها الاشياء اللي ف الفيربيس
  DocumentSnapshot<Map<String, dynamic>> docData; // for printing
  var username; // for display to user
  var useremail;
  var fav;

  getUserData(String uid) async {
    //اجيب بيانات دوكيمنت واحد فقط
    //get will return docs Query snapshot
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) async {
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
      } else {}
    });
    fetchSpecifiedProduct();
  }

  Future fetchSpecifiedProduct() async {
    //استخراج البرودكت من الفايبر بيس
    //هذا اللي يجيب ال doc على الابلكيشن
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .where('family store id', isEqualTo: widget.selectedFamilyStore.id)
      //.where('uid', isNotEqualTo: docData.id)
          .get()
          .then((specifiedDoc) async {
        if (specifiedDoc != null && specifiedDoc.docs.isEmpty == false) {
          setState(() {
            productsList = specifiedDoc;
            // for (int i = 0; i < productsList.docs.length; i++) {
            //   productName = productsList.docs[i].data()['product name'];
            //   productId = productsList.docs[i].data()['product id'];
            //   productDescription = productsList.docs[i].data()['product description'];
            //   categoryName = productsList.docs[i].data()['category name'];
            //   price = productsList.docs[i].data()['price'];
            //   image = productsList.docs[i].data()['image product'];
            // }
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
  //ستخراج الداتا يكون هنا ف الميثود دي
  void initState() {
    if (firebaseUser != null && firebaseUser.uid != null) {
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
        title:
        // Row(
        //   children: [
        //     Hero(
        //       tag: widget.imageStore,
        //       child:
        //       widget.imageStore != null ?
        //       Image.network(widget.imageStore,
        //         fit: BoxFit.cover,
        //         height: 30,
        //         width: 30,
        //       ):
        //       Image.network("https://previews.123rf.com/images/thesomeday123/thesomeday1231712/thesomeday123171200009/91087331-default-avatar-profile-icon-for-male-grey-photo-placeholder-illustrations-vector.jpg",
        //         fit: BoxFit.cover,
        //         height: 30,
        //         width: 30,
        //       )    ),

            Padding(
              padding: EdgeInsets.only(top: 1),
              child: Text(

                "${widget.selectedFamilyStore.data()['family store name'].toString()}'s Products",
                style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                softWrap: true,

              ),
            ),
        //   ],
        // ),
        backgroundColor: basicColor,
        toolbarHeight: 80,
      ),
      endDrawer: MainDrawer(
        username: username,
        useremail: useremail,
      ),
      backgroundColor: basicColor,
      body: ListView(

          children: <Widget>[
        SizedBox(
          height: 20,
        ),
            // Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 35),
            //     child: Text(widget.familyDescription)),//between them
        productFlowList(context),
      ]),
    );
  }

  //هنا افصلهن عن بعض واعرضهم ف الابلكيشن عن جد

  Widget productFlowList(BuildContext context) {
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
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text("Store abstract:  ${widget.familyDescription}",textAlign: TextAlign.center,style:
                TextStyle(color: black,fontSize: 30,fontStyle: FontStyle.italic,fontWeight: FontWeight.w700))),
            Padding(
                padding: EdgeInsets.only(top: 45),
                child: Container(
                  height: MediaQuery.of(context).size.height - 300,
                  child: productsList.docs.isEmpty
                      ? Center(
                    child: Text(
                      "no elements",
                      style: TextStyle(color: black),
                    ),
                  )
                      : ListView.separated(
                    itemCount: productsList.docs.length,
                    separatorBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 3,
                        color: basicColor,
                      ),
                    ),
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => ProductDetails(
                              selectedProduct: productsList.docs[i]));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Hero(
                                      tag: productsList.docs[i].data()['product id'].toString(),
                                      child: productsList.docs[i].data()['image product'].toString() != null
                                          ? Image.network(
                                        productsList.docs[i].data()['image product'].toString(),
                                        fit: BoxFit.cover,
                                        height: 75,
                                        width: 75,
                                      )
                                          : Image.network(
                                        "https://thumbs.dreamstime.com/b/product-icon-collection-trendy-modern-flat-linear-vector-white-background-thin-line-outline-illustration-130947207.jpg",
                                        fit: BoxFit.cover,
                                        height: 75,
                                        width: 75,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        productsList.docs[i].data()['product name'].toString() ?? "none",
                                        style: TextStyle(color: black, fontSize: 17, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      // Text(productsList.docs[i].id),

                                      Container(
                                          width: 200,
                                          child: Text(
                                            productsList.docs[i].data()['product description'].toString() ?? "none",
                                            softWrap: true,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: grey),
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${productsList.docs[i].data()['category name'].toString()} Store" ?? "none",
                                        style: TextStyle(color: black),
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
    } else {
      return Container(
          height: MediaQuery.of(context).size.height - 180,
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100),
                bottomRight: Radius.circular(150),
              )),
          child: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CircularProgressIndicator(), Text("No products")])));
    }
  }


}
