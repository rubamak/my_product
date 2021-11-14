


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/pages/families_screen.dart';
import 'package:my_product/pages/home_page.dart';
import 'package:get/get.dart';


class HorizontelList extends StatefulWidget {
  const HorizontelList({Key key}) : super(key: key);

  @override
  State<HorizontelList> createState() => _HorizontelListState();
}

class _HorizontelListState extends State<HorizontelList> {

  QuerySnapshot<Map <String, dynamic>> categoryList;

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  Future getCategories() async {
    try {
      await FirebaseFirestore.instance.collection('categories').get().then((catDocs) async {
        if (catDocs != null && catDocs.docs.isEmpty == false) {
          setState(() {
            // put each doc in the map categoryList..
            categoryList = catDocs;});
        } else {
          print('No Docs Found');
        }
      });
    } catch (e) {
      print('Error Fetching Data is: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
     // height: MediaQuery.of(context).size.height-150,
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,

      //height: MediaQuery.of(context).size.height-100,
      // width: MediaQuery.of(context).size.width-150,
      child: categoriesFlowList(context),
    );
  }
  Widget categoriesFlowList(BuildContext context){
    if(categoryList!=null && categoryList.docs.isEmpty==false){
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        itemCount: categoryList.docs.length,
        itemBuilder: (context, i) {
          return InkWell(
            borderRadius: BorderRadius.circular(50),
            splashColor: grey,
            child: Card(

              child: Column(children: [
                Container(
                 //height: MediaQuery.of(context).size.height-250,
                 // width: MediaQuery.of(context).size.width-250,
                  padding: EdgeInsets.all(30),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        categoryList.docs[i].data()['image'].toString(),
                       //width: 100,
                        height: 100,//MediaQuery.of(context).size.height * 0.2,
                      )),
                  margin: EdgeInsets.all(20),
                ),
                Text(
                  categoryList.docs[i].data()['name'].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ]),
            ),
            onTap: (){
              Get.to(()=> FamiliesScreen(selectedCategory: categoryList.docs[i] ) );
              // Navigator.of(context).push(new MaterialPageRoute(
              //     builder: (BuildContext context) =>
              //         FamiliesScreen( selectedCategory: categoryList.docs[i],)))

            },
          );
        },
      );
    }else{
      return Container(child: Center(child: CircularProgressIndicator()));
    }
  }


}



