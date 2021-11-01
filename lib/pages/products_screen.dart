import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/dummy_data.dart';
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
  QuerySnapshot<Map<String, dynamic>> productsList;
  DocumentSnapshot<Map<String, dynamic>> docData; // for printing
  // var username; // for display to user
  // var useremail;

  getUserData(String uid) async {
    //اجيب بيانات دوكيمنت واحد فقط
    //get will return docs Query snapshot
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) async{
      //value.data is the full fields for this doc
      if (value.exists) {
        setState(() {
          docData = value;
          // useremail = docData['email'];
          // username = docData['username'];
        });

      } else {
        //fetchSpecifiedFamilyStore();
      }
    });
    fetchSpecifiedProduct();

  }

  Future fetchSpecifiedProduct() async {
    // print('Inside Fetching Data UID=${docData.id}');
    print('Inside Fetching Data CatID=${widget.selectedFamilyStore.id}');
    if(firebaseUser!= null  ){
      //   print("uhuigiugiugohyesssssssssssssssssssssssssssssssssss");
      try  {
        await FirebaseFirestore.instance.collection('products')
            .where('family store id', isEqualTo: widget.selectedFamilyStore.id)
            .where('uid', isNotEqualTo: docData.id)
            .get().then((specifiedDoc) async {
          if (specifiedDoc != null && specifiedDoc.docs.isEmpty == false) {
            setState(() {

              productsList=specifiedDoc;
            });
          } else {
            print('No Docs Found');
          }
        });
      } catch (e) {
        print('Error Fetching Data$e');
      }
    }
    else {
      print(" user null");
      try {
        await FirebaseFirestore.instance.collection('products')
            .where('family store id', isEqualTo: widget.selectedFamilyStore.id).get().then((specifiedDoc) async {
          if (specifiedDoc != null && specifiedDoc.docs.isEmpty == false) {
            setState(() {
              productsList = specifiedDoc;
              print("product added to map");
              //familiesStoresList.docs.clear();
            });
          } else {
            print('No Docs Found');

          }
        });
      } catch (e) {
        print('Error Fetching Data $e');
      }
    }
  }
  @override
  void initState() {
    if (firebaseUser != null && firebaseUser.uid.isNotEmpty){
      print( "user not null=================");
      getUserData(firebaseUser.uid);
    }else {
      fetchSpecifiedProduct();
     // print("this is id for category choose ${widget.selectedFamilyStore.id}");
      print( " user is null ");

    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final familyId = routeArg['id'];
    final familyName = routeArg['name'];

    final products = DUMMY_PRODUCTS;
    //     .where((product) {
    //   return product.familyId == familyId;
    // }).toList();

      return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
            // color: black,
          ),
          title: Padding(
            padding: EdgeInsets.only(top: 1),
            child: Text(
              "${widget.selectedFamilyStore.data()['family store name'].toString()} Products",
              style: TextStyle(
                color: black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          backgroundColor: Color(0xFF90A4AE),
          toolbarHeight: 80,
        ),
       // endDrawer: MainDrawer(username: username, useremail: useremail,),
        backgroundColor: basicColor,
        body: ListView(
            children: <Widget>[
              SizedBox(height: 20,),
              //Text(familiesStoresList!= null ? familiesStoresList.docs[0].data()['family store name']: " null"),
              ProductFlowList(context),
            ]),
      );
    }
  Widget ProductFlowList(BuildContext context){
    if(productsList != null ){
      return Container(
        height: MediaQuery.of(context).size.height - 180,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100),
              bottomRight: Radius.circular(150),
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
                    child: Text("no elements"),
                  )
                      : ListView.separated(
                    itemCount: productsList.docs.length,
                    separatorBuilder: (context, i) => Container(
                      height: 1,
                      color: grey,
                    ),
                    itemBuilder: (context, i) {
                      return ProductItem(

                        familyId: productsList.docs[i].data()['family store id'].toString(),
                        description: productsList.docs[i].data()['product description'].toString(),
                        categoryName: productsList.docs[i].data()['category name'].toString(),
                        uid: firebaseUser == null ? " no user": firebaseUser.uid.toString(),
                        productId:productsList.docs[i].data()['product id'].toString(),
                        productName: productsList.docs[i].data()['product name'].toString(),
                        price: double.parse(productsList.docs[i].data()['price'].toString()),
                        productImage: productsList.docs[i].data()['image product'].toString(),
                        categoryId: productsList.docs[i].data()['category id'].toString(),
                      );
                    },
                  ),
                ))
          ],
        ),
      );

    }else{
      return Container(
        height: MediaQuery.of(context).size.height - 180,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100),
              bottomRight: Radius.circular(150),
            )),
        child:
        Center(child: Text("No Products Stores"),),





      );

    }


  }

      // body: ListView(
      //     children: <Widget>[
      //       SizedBox(height: 20,), //between them
      //       Container(
      //         height: MediaQuery.of(context).size.height - 180,
      //         decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.only(topLeft: Radius.circular(100),bottomRight:Radius.circular(150),)),
      //
      //         child:productsList != null? ListView(
      //           primary: false,
      //           physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      //           padding: EdgeInsets.only(left: 25, right: 25),
      //           children: <Widget>[
      //             Padding(
      //               padding: EdgeInsets.only(top: 45),
      //               child: Container(
      //                 height: MediaQuery.of(context).size.height - 300,
      //                 child: productsList.docs.isEmpty? Center(
      //                   child: Text("no elements"),
      //                 )
      //                     : ListView.separated(
      //                   itemCount: productsList.docs.length,
      //                   separatorBuilder: (context, i) => Container(
      //                     height: 1,
      //                     color: grey,
      //                   ),
      //                   itemBuilder: (context,i){
      //                     return ProductItem(
      //                       productName: productsList.docs[i].data()['product name'],
      //                       productId: productsList.docs[i].data()['product id'],
      //                       productImage: productsList.docs[i].data()['product image'],
      //                       description:productsList.docs[i].data()['product description'] ,
      //                       price: productsList.docs[i].data()['price'],
      //                       categoryId: productsList.docs[i].data()['category id'],
      //                       categoryName: productsList.docs[i].data()['category name'],
      //                       familyId: productsList.docs[i].data()['family store id'],
      //
      //                     );
      //                   },
      //                 ),

                      // child:
                      // ListView(
                      //   children: products.map((productItem) =>
                      //       ProductItem(
                      //           productId: productItem.productId,
                      //           productName: productItem.productName,
                      //           productImage: productItem.productImage,
                      //           price: productItem.price,
                      //           description: productItem.description)
                      //   ).toList(),
                      // ),
                   // ),
    //               ),
    //             ],
    //           ):
    //           Container(
    //             height: MediaQuery.of(context).size.height - 180,
    //             decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.only(
    //                   topLeft: Radius.circular(100),
    //                   bottomRight: Radius.circular(150),
    //                 )),
    //             child:
    //             Center(child: Text("No Families Stores"),),
    //
    //
    //
    //
    //
    //           ),
    //         )
    //       ]
    //   ),
    // );

}