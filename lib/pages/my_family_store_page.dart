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
  User firebaseUser = FirebaseAuth.instance.currentUser;
  QuerySnapshot <Map<String, dynamic>> familyStoreInfo ;
  var docData ;
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
            .where('uid',isEqualTo: docData.id).get().then((doc) {
          if(doc != null && doc.docs.isEmpty == false){
            setState(() {
              familyStoreInfo = doc;
              hasStore = true;
            });

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
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          centerTitle: true,
          elevation: 0,
          title: hasStore? Column(
            children: [
              Text(" My store: ${familyStoreInfo.docs[0].data()['family store name'].toString()}",),
              Text(" Type: ${familyStoreInfo.docs[0].data()['category name'].toString()} Store")
            ],
          ): Text("no store"),
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

              Center(child:  hasStore?
              Column(children: [
                Text("my products here ")

              ],)
                  : Text("No Store Added,",style: TextStyle(fontSize: 40),),)


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
        ),
      );

  }
}
