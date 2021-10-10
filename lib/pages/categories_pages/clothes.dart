import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Clothes extends StatefulWidget {
  const Clothes({Key? key}) : super(key: key);

  @override
  _ClothesState createState() => _ClothesState();
}

class _ClothesState extends State<Clothes> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Clothes Category"),
          backgroundColor: const Color(0xffFFBCBC)
      ) ,
      /*body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("products").snapshots(),
        builder: (context,snapshot) {
          if(!snapshot.hasData) return const Text('Loading..');
          //otherwise
          ListView.builder(
            itemCount: snapshot.data.documents().length ,
            itemExtent: 60.0,
            itemBuilder: (context,index) =>
            ,


          )

        },

      ),*/

    );
  }
}