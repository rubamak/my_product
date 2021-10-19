import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/pages/drawer_section_pages/add_family_store.dart';

class MyFamilyStorePage extends StatelessWidget {
  // const MyFamilyStorePage({Key? key}) : super(key: key);
// CollectionReference
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        elevation: 0,
        title: Text("My Store"),
        backgroundColor: Theme.of(context).primaryColor,
      ),

      body:  Container(
        color: basicColor,
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(120),
              )
          ),

          child: Center(
            child: Text("No Store Added,",style: TextStyle(fontSize: 40),),),
        ),
      ),
      floatingActionButton: Container(
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: basicColor,
          ),
          child: TextButton.icon(
            label: Text("add Your Store",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: white),),
            icon: Icon(Icons.add,color: white,),
            onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> AddFamilyStore())),

          )
      ),
    );

  }
}
