import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'dart:io';
import 'dart:ui';
import 'package:my_product/modules/product.dart';
import 'package:my_product/pages/my_products_page.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> selectedProduct;

  ProductDetails({this.selectedProduct,} );

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  User firebaseUser = FirebaseAuth.instance.currentUser;
  QuerySnapshot<Map<String, dynamic>> productInfo;

  //QuerySnapshot<Map<String, dynamic>> productsList;
  DocumentSnapshot<Map<String, dynamic>> docData;

  getProduct(String uid) async {
    //اجيب بيانات دوكيمنت واحد فقط
    //get will return docs Query snapshot
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) async {
      //value.data is the full fields for this doc
      if (value.exists) {
        setState(() {
          docData = value;
          print(docData.id);
        });
        try {
          await FirebaseFirestore.instance.collection('products')
              //.where('uid', isNotEqualTo: docData.id)
              .where('product id', isEqualTo: widget.selectedProduct.id.toString())
              .get().then((specifiedDoc) async {
            if (specifiedDoc != null && specifiedDoc.docs.isEmpty == false) {
              setState(() {
                productInfo = specifiedDoc;
              });
            } else {
              print('No Docs Found');
            }
          });
        } catch (e) {
          print('Error Fetching Data$e');
        }
      }
    });
  }

  @override
  void initState() {
    getProduct(firebaseUser.uid);
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

        title:
            Padding(
          padding: EdgeInsets.only(top: 1),
          child: Text(
            "${productInfo.docs[0].data()['product name'].toString()}'s details",
            style: TextStyle(
              color: black,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
        ),
        backgroundColor: basicColor,
        toolbarHeight: 80,
      ),
      body: Container(
          color: basicColor,
          child: Container(
              height: MediaQuery.of(context).size.height - 100,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(120),
                  )),
              child: ListView(children: [
                productInfo != null ? Text("${productInfo.docs[0].data()['product name'].toString()} details"):
                    Text("none")
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

  Container buildContainer(String image, String desc, BuildContext context) {
    return Container(
      child: Center(
        child: Hero(
          tag: desc,
          child: Image.file(
            File(image),
            fit: BoxFit.contain,
            height: MediaQuery.of(context).size.height - 500,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }

  Card buildCard(String title, String category, String familyName, String desc, double price) {
    return Card(
      elevation: 20,
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: black),
            ),
            Divider(
              color: black,
            ),
            Text(
              desc,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: black),
              textAlign: TextAlign.justify,
            ),
            Divider(
              color: black,
            ),
            Text(
              "$price SR",
              style: TextStyle(fontSize: 20, color: black, fontWeight: FontWeight.bold),
            ),
            Divider(
              color: black,
            ),
            Text(
              familyName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: black),
            ),
            Divider(
              color: black,
            ),
            Text(
              category,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: black),
            ),
            Divider(
              color: black,
            ),
          ],
        ),
      ),
    );
  }
}
