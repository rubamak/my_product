import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/modules/product.dart';
import 'package:my_product/widgets/product_item.dart';
import 'package:my_product/dummy_data.dart';
import 'package:my_product/pages/login.dart';

class FavoriteScreen extends StatefulWidget {




  //static const routeName = '/favorite-screen';
//

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  getFavoraite() async {
    // try {
    //   await FirebaseFirestore.instance.collection('favorites')
    //      // .where('family store id', isEqualTo: widget.selectedFamilyStore.id)
    //   //.where('uid', isNotEqualTo: docData.id)
    //       .get().then((specifiedDoc) async {
    //     if (specifiedDoc != null && specifiedDoc.docs.isEmpty == false) {
    //       setState(() {
    //         productsList = specifiedDoc;
    //       });
    //     } else {
    //       print('No Docs Found');
    //     }
    //   });
    // } catch (e) {
    //   print('Error Fetching Data$e');

  }


  Widget build(BuildContext context) {


        return Scaffold(
          body: Center(
            child: Text("no items yet",style: TextStyle(color:black ),),
          )
      );

      return  // في خلل هناااااااااااااااااااااااا يطلع راندر ايرور
        ListView.builder(
            itemBuilder: (context, index) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return null;
                    // ProductItem(
                    //   productId: favoriteProducts[index].productId,
                    //   productName: favoriteProducts[index].productName,
                    //   productImage: favoriteProducts[index].productImage,
                    //   price: favoriteProducts[index].price,
                    //   description: favoriteProducts[index].description);


                },
                // itemCount: favoriteProducts.length,
              );
            }

        );

  }
}
