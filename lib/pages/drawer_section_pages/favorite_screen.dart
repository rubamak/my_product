import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/modules/product.dart';
import 'package:my_product/widgets/product_item.dart';
import 'package:my_product/dummy_data.dart';
import 'package:my_product/pages/login.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Product> favoriteProducts;

  FavoriteScreen(this.favoriteProducts);

  //static const routeName = '/favorite-screen';
//
  @override
  Widget build(BuildContext context) {
    if (favoriteProducts.isEmpty) {
      return Scaffold(
          body: Center(
            child: Text("no items yet",style: TextStyle(color:black ),),
          )
      );
    } else {
      return  // في خلل هناااااااااااااااااااااااا يطلع راندر ايرور
        ListView.builder(
            itemBuilder: (context, index) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ProductItem(
                      productId: favoriteProducts[index].productId,
                      productName: favoriteProducts[index].productName,
                      productImage: favoriteProducts[index].productImage,
                      price: favoriteProducts[index].price,
                      description: favoriteProducts[index].description);


                },
                // itemCount: favoriteProducts.length,
              );
            }

        );
    }
  }
// Future addToFavorite() async{
//   final Firebase _auth = FirebaseAuth.instance as Firebase;
//   var currentUser = _auth._email;
//   CollectionReference _collectionRef =
//   FirbaseFirestore.instance.collection("user-favorite-item");
//   return _collectionRef
//       .doc(currentUser!.email)
//       .collection("collectionPath")
//       .doc()
//       .set({"name":widget._product["product-name"]}).then((value) => print("added to favorite"))



//  }
}
