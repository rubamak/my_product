import 'package:flutter/material.dart';
class DigitalServices extends StatefulWidget {
  const DigitalServices({Key? key}) : super(key: key);

  @override
  _DigitalServicesState createState() => _DigitalServicesState();
}

class _DigitalServicesState extends State<DigitalServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Digital Services Category"),
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
