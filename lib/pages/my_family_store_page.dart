import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/pages/add_product.dart';
import 'package:my_product/pages/drawer_section_pages/add_family_store.dart';
import 'package:get/get.dart';

class MyFamilyStorePage extends StatefulWidget {
  // const MyFamilyStorePage({Key? key}) : super(key: key);
  @override
  State<MyFamilyStorePage> createState() => _MyFamilyStorePageState();
}

class _MyFamilyStorePageState extends State<MyFamilyStorePage> {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  var storesRef = FirebaseFirestore.instance.collection('familiesStores');

  var familyStore;

  var description;

  bool hasStore = false;

  checkStore()async {
   await storesRef.where('uid',isEqualTo: firebaseUser.uid).get().then((value) {

   setState(() {
     value.docs.forEach((element) {
       familyStore =element.data();
       print(familyStore);
     });
     hasStore= true;

   });

   });
   return hasStore;



  }

  var storeData;

  getStore(String uid) async {

      //استعلام كامل لهذا الكولكيشن
      QuerySnapshot querySnapshot = await storesRef.where('uid',isEqualTo:uid).get();
      //all the docs in list
      List <dynamic> listDocs = querySnapshot.docs;
      // for each document get the data for specific field
      listDocs.forEach((element) {
        storeData = element.data();

        print(element.data());
        print("================================");
      });
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        elevation: 0,
        title: hasStore ?
            Text(familyStore)
            :Text("No store"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        color: basicColor,
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(120),
              )
          ),

          child:

          Center(
            child: Text("No Store Added,",style: TextStyle(fontSize: 40),),)


        ),
      ),






        floatingActionButton: Container(
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: basicColor,
          ),
          child:
              hasStore? TextButton.icon(
                label: Text("add products",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: white),),
                icon: Icon(Icons.add,color: white,),
                onPressed: ()=>
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=> AddProduct())),
                    Get.to(()=> AddProduct()),
              ):
          TextButton.icon(
            label: Text("add a Store",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: white),),
            icon: Icon(Icons.add,color: white,),
            onPressed: ()=>
                //Navigator.push(context, MaterialPageRoute(builder: (context)=> AddFamilyStore())),
                Get.to(()=> AddFamilyStore()),
          )
      ),
    );

  }
}
