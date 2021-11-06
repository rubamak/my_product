import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/pages/drawer_section_pages/add_product.dart';
import 'package:my_product/pages/drawer_section_pages/add_family_store.dart';
import 'package:get/get.dart';

import 'edit_product_screen.dart';

class MyFamilyStorePage extends StatefulWidget {
  @override
  State<MyFamilyStorePage> createState() => _MyFamilyStorePageState();
}

class _MyFamilyStorePageState extends State<MyFamilyStorePage> {
  User firebaseUser = FirebaseAuth.instance.currentUser;
  QuerySnapshot <Map<String, dynamic>> familyStoreInfo ;
  QuerySnapshot<Map<String, dynamic>> productsList;
  DocumentSnapshot <Map<String, dynamic>> docData ;
  bool hasStore = false;


  getUserData(String uid) async {
    //اجيب بيانات دوكيمنت واحد فقط
    //get will return docs Query snapshot
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) async{
      //value.data is the full fields for this doc
      if (value.exists) {
        setState(() {
          docData = value;
          print(docData.id);
        });
        await FirebaseFirestore.instance.collection('familiesStores')
            .where('uid',isEqualTo: docData.id).get().then((doc) async{
          if(doc != null && doc.docs.isEmpty == false){
            setState(() {
              familyStoreInfo = doc;
              hasStore = true;
            });
            try {
              await FirebaseFirestore.instance.collection('products')
                  .where('uid',isEqualTo: docData.id)
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
          }
        });
      } else {
        setState(() {
          hasStore= false;

        });
      }
    });

  }


  @override
  void initState() {
   getUserData(firebaseUser.uid);
   // getProductsUser();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          toolbarHeight: 100,
          centerTitle: true,
          elevation: 0,
          title: hasStore? Column(
            children: [
              Text(" My store ",style: TextStyle(color: black,fontSize: 30),),
              //Text(" Type: ${familyStoreInfo.docs[0].data()['category name'].toString()} Store")
            ],
          ): Text("no store",style: TextStyle(color: black,fontSize: 30),),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
            color: basicColor,
            child: Container(
                height: MediaQuery.of(context).size.height - 100,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(120),
                    )
                ),

                child:familyStoreInfo== null?
                Center(child: CircularProgressIndicator(),)
                    : ListView(
                  physics: NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),

                  children:[
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                  hasStore? Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                      Hero(
                      tag: familyStoreInfo.docs[0].data()['family id'].toString(),
                  child:
                  familyStoreInfo.docs[0].data()['image family store'].toString() != null ?
                  Image.network(familyStoreInfo.docs[0].data()['image family store'].toString(),
                    fit: BoxFit.cover,
                    height: 75,
                    width: 75,
                  ):
                      Image.asset("images/noFamily.jpg",
                    fit: BoxFit.cover,
                    height: 75,
                    width: 75,
                  )    ),

            SizedBox(width: 10,),
            Column(

              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                  Text(familyStoreInfo.docs[0].data()['family store name'].toString()
                      ??"none",style: TextStyle(color:black,fontSize: 17,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),

                  Container(
                      width: 200,
                      child:
                      Text(familyStoreInfo.docs[0].data()['store description'].toString()??"none",
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(fontSize: 17,fontWeight: FontWeight.normal,color: grey),)
                  ),
                  Text("${familyStoreInfo.docs[0].data()['category name'].toString()} Store" ??"none",
                    style: TextStyle(color:black),),
              ],
            )
            ],
          ),


            ): Text("No store")
          ]
                    ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Divider(height: 2,color: black,),
                    ),
                    SizedBox(height: 30,),
                    Text("My Products",textAlign: TextAlign.center,style: TextStyle(fontSize: 30,color: black),),
              SizedBox(height: 20,),


              productsFlowList(context),
                  ],

                ),
            ),

        ),


        floatingActionButton: Container(
            width: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: basicColor,
            ),
            child:
            hasStore?
            TextButton.icon(
              label: Text("add products",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: black),),
              icon: Icon(Icons.add,color: black,),
              onPressed: ()=>
              //Navigator.push(context, MaterialPageRoute(builder: (context)=> AddProduct())),
              Get.to(()=> AddProduct()),
            )
                : TextButton.icon(
              label: Text("add a Store",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: black),),
              icon: Icon(Icons.add,color: black,),
              onPressed: ()=>
              //Navigator.push(context, MaterialPageRoute(builder: (context)=> AddFamilyStore())),
              Get.to(()=> AddFamilyStore()),
            )

        ));

  }
  Widget productsFlowList(BuildContext context ) {
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
                    separatorBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(padding: EdgeInsets.all(10),height: 3, color: black,),
                    ),
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: (){
                          //ProductsScreen(selectedFamilyStore: ,));
                          Get.to(()=> EditProductScreen(selectedProduct: productsList.docs[i]));
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
                                      Image.network("https://previews.123rf.com/images/thesomeday123/thesomeday1231712/thesomeday123171200009/91087331-default-avatar-profile-icon-for-male-grey-photo-placeholder-illustrations-vector.jpg",
                                        fit: BoxFit.cover,
                                        height: 75,
                                        width: 75,
                                      )    ),

                                  SizedBox(width: 10,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 5,),


                                          Text(
                                            productsList.docs[i].data()['product name'].toString()??
                                                "none",
                                            softWrap: true,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal,color: grey),),
                                      SizedBox(height: 5,),
                                      Container(
                                        width: 200,
                                        child: Text(
                                          productsList.docs[i].data()['product description'].toString()??
                                              "none",
                                          maxLines: 1,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: grey),),
                                      ),
                                      SizedBox(height: 5,),

                                      Text(
                                          "${productsList.docs[i].data()['price'].toString()} SR" ??
                                         "none",
                                        softWrap: true,

                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color:black),),

                                    ],
                                  )
                                ],
                              ),
                            ),
                            Icon(Icons.edit_outlined),

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
          height: MediaQuery
              .of(context)
              .size
              .height - 180,
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100),
                bottomRight: Radius.circular(150),
              )),
          child:  Text("No products added",textAlign: TextAlign.center,));
    }
  }
}
