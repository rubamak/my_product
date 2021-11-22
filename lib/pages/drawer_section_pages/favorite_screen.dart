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
import 'package:my_product/widgets/main_drawer.dart';
import 'package:my_product/widgets/product_item.dart';
import 'package:my_product/dummy_data.dart';
import 'package:my_product/pages/login.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = '/favorite-screen';

  @override
  State <FavoriteScreen> createState() => _FavoriteScreenState();


}

class _FavoriteScreenState extends State<FavoriteScreen>{

  User firebaseUser = FirebaseAuth.instance.currentUser;
  QuerySnapshot<Map<String, dynamic>> favoriteList;
  var docData;
  var description;
  var username; // for display to user
  var useremail;

  // var productId;
  getFavorites() async {

    //اجيب بيانات دوكيمنت واحد فقط
    //get will return docs Query snapshot
    await FirebaseFirestore.instance.collection('favorites').
    doc(firebaseUser.uid).collection('favorites_products_user')
        .get().then((doc) async{
      //value.data is the full fields for this doc

      if (doc != null && doc.docs.isEmpty == false) {
        setState(() {
          favoriteList= doc;
          // print(value.id);

        });
      } else {
      }
    });
  }

  void initState() {
    if (firebaseUser != null ){
      getFavorites();


    }
    print(favoriteList);
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: //between them
      FavoriteFlowList(context),
    );
  }
  Widget FavoriteFlowList(BuildContext context){
    if (favoriteList != null) {
      return
        Container(
          height: MediaQuery.of(context).size.height - 200,
          color: Colors.transparent,
          child:
          ListView(
            primary: false,
            physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            padding: EdgeInsets.only(left: 25, right: 25),
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height - 300,
                    child: favoriteList.docs.isEmpty ? Center(
                      child: Text("no elements",style: TextStyle(color: black),),
                    )
                        : ListView.separated(
                      itemCount: favoriteList.docs.length,
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
                            Get.to(()=> ProductDetails(selectedProduct: favoriteList.docs[i],));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                color: Colors.transparent,
                                child: Row(
                                  children: <Widget>[
                                    Hero(
                                        tag: favoriteList.docs[i].id,
                                        child:
                                        favoriteList.docs[i].data()['image'].toString() != null ?
                                        Image.network(favoriteList.docs[i].data()['image'].toString(),
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

                                        Text(favoriteList.docs[i].data()['product name'].toString()
                                            ??"none",style: TextStyle(color:black,fontSize: 20,fontWeight: FontWeight.bold),),
                                        SizedBox(height: 5,),
                                        // Text(productsList.docs[i].id),

                                        Container(
                                            width: 200,
                                            child:
                                            Text(favoriteList.docs[i].data()['description'].toString()??"none",
                                              softWrap: true,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal,color: black),)
                                        ),
                                        Text("${favoriteList.docs[i].data()['price'].toString()} SR" ?? "none",
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
            ],
          ),
        );
    }else{
      return Container(
        child: Center(child: Text("no favorites products"),),);
    }
  }
}