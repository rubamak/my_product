import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_product/color/my_colors.dart';

//my imports

import 'package:my_product/components/horizontel_listview.dart';
import 'package:my_product/components/latest_products.dart';
import 'package:my_product/pages/cart_screen.dart';
import 'package:my_product/widgets/main_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
 // const HomePage({Key? key, required Object uid}) : super(key: key);
  static const routeName = '/homepage-screen';



  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //String str = 'Home Page';
 var url = "https://www.youtube.com/watch?v=nIH3i7fjd2U";
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    //this the size of the screen
    Size size = MediaQuery.of(context).size;

    Widget imageCarousal = Container(
      margin: const EdgeInsets.only(top: 20.0),

      height: size.height * 0.2, //150.0,
      child: Carousel(
        boxFit: BoxFit.contain,
        images: const [
          AssetImage("images/myLogo.png"),
          AssetImage('images/adv.jpeg'),
          AssetImage('images/cob.png'),
          NetworkImage(
              'https://onlinedjradio.com/wp-content/uploads/2016/10/ads.jpeg'),
          AssetImage('images/download.jpeg'),
          AssetImage(
            'images/images.jpeg',
          ),
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

        appBar: AppBar(
          actions: [

            IconButton(
                icon: Icon(Icons.shopping_cart_outlined, color: white),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
                }),
            IconButton(
                icon: Icon(Icons.settings, color: white),
                onPressed: () {
                }),
          ],

          //shape:,

          elevation: 0,
          toolbarHeight: 110,
          backgroundColor: basicColor,
          title: Text('Home Page', style: TextStyle(color: white,fontSize: 30),),
          centerTitle: true,


         // leading:  ,

          // actions: <Widget>[
          //   IconButton(
          //       icon: Icon(Icons.shopping_cart_outlined, color: white),
          //       onPressed: () {
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => CartScreen()));
          //       }),
          //   IconButton(
          //       icon: Icon(Icons.notifications, color: white),
          //       onPressed: () {}),
          //   /*Switch(
          //     value: isSwitched,
          //     onChanged: (value) {
          //      setState(() {
          //        isSwitched = value;
          //        print(isSwitched);
          //
          //        if(isSwitched== true){
          //          black = Colors.white;
          //          white = Colors.black;
          //        }
          //        if(isSwitched== false) {
          //          black = Colors.black;
          //          white =  Colors.white;
          //        }
          //
          //      });
          //
          //     },
          //   activeColor: Colors.white,
          //   inactiveThumbColor: Colors.black,
          //   inactiveTrackColor: Colors.black,
          //
          //   ),*/
          // ],
        ),

       drawer: MainDrawer(),

        //body of the page
        body: Container(

          height: MediaQuery.of(context).size.height - 180,
          width: double.infinity,
          //color: white,
          child: SingleChildScrollView(
            child: Column(
              //child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //gridDelegate:  new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2),
              children: <Widget>[
                // CustomText(text: "hello", size: 20.0, colors: Colors.black, weightFont: FontWeight.w400),
                  SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: EdgeInsets.all(5),
                    height: 50,
                    decoration: BoxDecoration(color: white, boxShadow: [
                      BoxShadow(
                        color: Color(0xFF90A4AE),
                        offset: Offset(5, 10),
                        blurRadius: 8,
                      )
                    ]),
                    child: ListTile(
                      leading: Icon(
                        Icons.search,
                        size: 50,
                        color:Color(0xFF90A4AE),

                    ),
                      title: TextField(
                        decoration: InputDecoration(
                          hintText: "Find what you want..",
                          hintStyle: TextStyle(
                              color:Color(0xFF90A4AE),
                              fontWeight: FontWeight.bold),
                          border: InputBorder.none,
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
                //use the carousal
                imageCarousal,

                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Our Categories',
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.w800))),
                ),

                //horizontal listview hereeee:
                HorizontelList(),

                Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Press Right for Latest Products! ',
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.w800))),



                //make it flexible with any screen to avoid problem
                //Flexible(child: Products()) ,
                // i put the latest products in floating button



              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => bottomSheet(context),
         /* async{
            try{
              await canLaunch(url)?
              await launch(url,):
              throw 'could not get the video';
            }catch(e){
              print(e.toString());

            }

          },*/


          backgroundColor: basicColor,
          child: Icon(
            Icons.new_label_outlined,
          ),
        ),

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




