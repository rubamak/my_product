


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_product/pages/home.dart';
import 'dart:convert';

import 'color/my_colors.dart';

//import 'package:my_product/color/my_colors.dart';

class JsonTest extends StatefulWidget {


  @override
  _JsonTestState createState() => _JsonTestState();


}

class _JsonTestState extends State<JsonTest> {


  Future fetchData() async {
    try{
      var res = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
      if(res.statusCode==200){
        var obj = json.decode(res.body);
        return obj;
        // print(" heeeeeeeeeeeeeeeeeee:${obj[2]["title"]}");

      }
    }catch(e){
      print('Exception = ' + e.toString());
      throw Exception(e);

    }
  }
  @override
  void initState(){
    super.initState();
    fetchData();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("test",)),
      body: FutureBuilder <dynamic> (  // make it dynamic for accept any type of data comes from Future
          future: fetchData(),
          builder:(BuildContext context, AsyncSnapshot<dynamic>snapshot) {// for more sure but here async dynamic
            // print(snapshot.data[0]['title']);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            } else {
              return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(

                      title: Text(snapshot.data[index]['title']),
                      leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data[index]['thumbnailUrl']),),
                      subtitle: Text("${snapshot.data[index]["id"]}"),
                    );
                  }

              );
            }
          }
     )
    );
  }
}
