import 'package:flutter/material.dart';
class Handmade extends StatefulWidget {
  const Handmade({Key? key}) : super(key: key);

  @override
  _HandmadeState createState() => _HandmadeState();
}

class _HandmadeState extends State<Handmade> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Handmade Category"),
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
