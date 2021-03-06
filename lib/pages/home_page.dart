import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/components/cart_screen.dart';

//my imports
import 'dart:async';
import 'package:my_product/components/horizontel_listview.dart';
import 'package:my_product/components/latest_products.dart';
import 'package:my_product/pages/chat/chat_rooms_screen.dart';
import 'package:my_product/pages/search.dart';
import 'package:my_product/widgets/main_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';


class HomePage extends StatefulWidget {
  // const HomePage({Key? key, required Object uid}) : super(key: key);
  // static const routeName = '/homepage-screen';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url = "https://www.youtube.com/watch?v=nIH3i7fjd2U";
  bool isSwitched = false;

  var firebaseUser = FirebaseAuth.instance.currentUser;
  var docData;// for printing
  var username; // for display to user
  var useremail;



  getUserData(String uid) async {
    //اجيب بيانات دوكيمنت واحد فقط
    DocumentReference documentReference = FirebaseFirestore.instance.collection(
        'users').doc(uid);
    //get will return docs Query snapshot
    await documentReference.get().then((value) {
      //value.data is the full fields for this doc
      if (value.exists) {
        setState(() {
          docData = value.data();

          useremail = docData['email'];
          username = docData['username'];

          // print(value.id);
        });
        // print(docData['uid']);
        print(docData['first name']);
        // print(docData['email']);
         //print(docData['first name']);
      } else {}
    });
  }

  @override
  void initState() {
    if (firebaseUser != null) {
      getUserData(firebaseUser.uid);
      //getCurrentUser();
      super.initState();
    } else {
      return;
    }
  }


  @override
  Widget build(BuildContext context) {
    //this the size of the screen
    Size size = MediaQuery
        .of(context)
        .size;

    Widget imageCarousal = Container(
      margin: const EdgeInsets.only(top: 20.0),

      height: size.height * 0.2, //150.0,
      child: Carousel(
        boxFit: BoxFit.contain,
        images: const [
          //AssetImage("images/myLogo.png"),
          AssetImage('images/adv.jpeg'),
          AssetImage('images/cob.png'),
          NetworkImage(
              'https://onlinedjradio.com/wp-content/uploads/2016/10/ads.jpeg'),
          AssetImage('images/download.jpeg'),
          // AssetImage(
          //   'images/images.jpeg',
          // ),
        ],
        autoplay: true,
        //how the images in carousal moves
        animationCurve: Curves.fastLinearToSlowEaseIn,
        animationDuration: const Duration(seconds: 8),
        dotSize: 4.0,
        //dotColor: Colors.black ,
        indicatorBgPadding: 4.0,
        dotBgColor: Colors.transparent,
      ),
    );
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        leading: Row(
          children: [
            Expanded(
              child: IconButton(
                  icon: Icon(Icons.search_rounded, size: 30,),
                  onPressed: () async{
                   Get.to(()=> Search());
                  // await FirebaseAuth.instance.signOut();
                  }),
            ),
            SizedBox(width: 20,),
            Expanded(
            child:IconButton(
                onPressed: (){

                  Get.to(()=> CartScreen());
                },
                icon:Icon( Icons.shopping_cart)))
          ],
        ),

        // elevation: 0,
        toolbarHeight: 110,
        backgroundColor: basicColor,
        title: Text(
          'My Product',
          style: TextStyle(color: black, fontSize: 30),
        ),
        centerTitle: true,
      ),

      endDrawer: MainDrawer(
        username: username,
        useremail: useremail,

      ),
      //body of the page
      body: SafeArea(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height - 180,
          width: double.infinity,
          //color: white,
          child: SingleChildScrollView(
            child: Column(
              //child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),

                //use the carousal
                imageCarousal,

                Container(
                  decoration:

                  BoxDecoration(

                      borderRadius: BorderRadius.circular(20),color: basicColor),
                  margin: EdgeInsets.all(20),
                  child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                      child: Text('Categories',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w400,
                          ) )),
                ),
                //horizontal listview here:
                HorizontelList(),
                SizedBox(
                  height: 20,
                ),

                Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text('Press here for Latest Products! ',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.w800,color: black))),

                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                        color: Colors.yellow[300]),
                    child: TextButton.icon(
                      label:Text("Latest Products",style: TextStyle(color: Colors.black,fontSize: 30),) ,
                      onPressed: ()=> bottomSheet(context),


                          //Text("Latest Products"),
                          icon: Icon(Icons.new_releases_outlined,color: black,size: 30,),
                        ),
                  ),
                ),


                //make it flexible with any screen to avoid problem
                //Flexible(child: Products()) ,
                // i put the latest products in floating button
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //
      //   heroTag: "floatButton",
      //   onPressed: () => bottomSheet(context),
      //   /* async{
      //       try{
      //         await canLaunch(url)?
      //         await launch(url,):
      //         throw 'could not get the video';
      //       }catch(e){
      //         print(e.toString());
      //
      //       }
      //
      //     },
      //

      // ),
    );
  }


  void bottomSheet(BuildContext cont) {
    showModalBottomSheet(
        context: cont,
        builder: (_) {
          return LatestProducts();
        });
  }




}

