import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:get/get.dart';
import 'package:my_product/pages/products_screen.dart';
import 'package:toast/toast.dart';

class Search extends StatefulWidget {

  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchTextController = TextEditingController();
  QuerySnapshot<Map<String, dynamic>> searchSnapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              //Navigator.of(context).pop();
              Get.back();
            },
            color: black,
          ),
          title: Padding(
            padding: EdgeInsets.only(top: 1),
            child: Text(
              "Searching",
              style: TextStyle(
                color: black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          backgroundColor: basicColor,
          toolbarHeight: 80,
        ),

        backgroundColor: basicColor,
        body:
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height - 130,
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(100),
                //bottomRight:Radius.circular(150),
              )),
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Container(
                  margin: EdgeInsets.all(5),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: white, boxShadow: [
                    BoxShadow(
                      color: basicColor,
                      offset: Offset(5, 10),
                      blurRadius: 8,
                    )
                  ]),
                  child: ListTile(
                    leading:  Icon(
                      Icons.search,
                      size: 30,
                      color: basicColor,
                    ),
                    title: TextField(
                      controller: searchTextController,

                      decoration:  InputDecoration(
                        hintText: "searching...",
                        hintStyle: TextStyle(
                            color: basicColor,
                            fontWeight: FontWeight.bold),
                        border: InputBorder.none,
                      ),
                    ),
                    trailing: TextButton(
                      child: Text("Find",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent),),
                      onPressed: (){
                        //searchToGetStoresNames(searchTextController.text);
                        initSearch();
                        setState(() {
                          searchTextController.clear();
                        });
                        FocusScope.of(context).unfocus();
                      },
                    ),

                  ),
                ),
              ),
              SizedBox(height:25,),
              searchList(),
            ],
          ),
        ));
  }
  initSearch(){
    searchToGetStoresNames(searchTextController.text.trim().toLowerCase())
        .then((value){
      print(value.docs[0].data()['family store name']);
      setState(() {

        searchSnapshot = value;
      });

    }).catchError((onError){
      Fluttertoast.showToast(msg: "No store with this name",backgroundColor: Colors.redAccent);
      print("Error searching: $onError ");
    });


  }
  Widget searchList(){
    return  searchSnapshot == null?
    Text("no searching ")
        :ListView.separated(
        separatorBuilder: (context,i){
          return Divider();
        },
        shrinkWrap: true,
        // scrollDirection: Axis.vertical,
        itemCount: searchSnapshot.docs.length,
        itemBuilder: (context,i){
          return InkWell(
            onTap: (){
              Get.to(()=> ProductsScreen(selectedFamilyStore: searchSnapshot.docs[i],));
            },
            child: SearchTile(
              searchStoreValue: searchSnapshot.docs[i].data()['family store name'].toString(),
              category:  searchSnapshot.docs[i].data()['category name'].toString(),
              storeDesc:  searchSnapshot.docs[i].data()['store description'].toString(),
              imageStore: searchSnapshot.docs[i].data()['image family store'].toString(),

            ),
          );
        });
  }

}
searchToGetStoresNames(String storeName)async{
  return await FirebaseFirestore.instance.collection('familiesStores')
      .where('family store name',isEqualTo:storeName)
      //.where('uid',isNotEqualTo:FirebaseAuth.instance.currentUser.uid)
      .get();
}


class SearchTile extends StatelessWidget {
  // const SearchTile({Key key}) : super(key: key);
  final String searchStoreValue ;
  final String category ;
  final String storeDesc;
  final String imageStore;
  SearchTile({this.searchStoreValue,this.category,this.storeDesc,this.imageStore});

  @override
  Widget build(BuildContext context) {
    return Container(

      width: double.infinity,
      child:  ListView(
          shrinkWrap: true,
          children:[ Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Hero(
                    tag: imageStore,
                    child:
                    imageStore != null ?
                    Image.network(imageStore,
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                    ):
                    Image.network("https://previews.123rf.com/images/thesomeday123/thesomeday1231712/thesomeday123171200009/91087331-default-avatar-profile-icon-for-male-grey-photo-placeholder-illustrations-vector.jpg",
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                    )
                ),
              ),
              Spacer(),
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( searchStoreValue,style: TextStyle(color: black ,fontWeight: FontWeight.w800,fontSize: 20),),
                    Text(storeDesc,
                        //maxLines: 3,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style:
                        TextStyle(color: black ,fontSize: 12)),
                    Text(category,style: TextStyle(color: Colors.indigoAccent ,fontSize: 12,fontWeight: FontWeight.w600,) ),


                  ],),
              ),
              Spacer(),


            ],),
          ]
      ),

    );
  }
}

