import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:my_product/modules/product.dart';
import 'package:my_product/pages/cart_screen.dart';
import 'package:my_product/widgets/main_drawer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key, required Object uid}) : super(key: key);
  static const routeName = '/homepage-screen';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url = "https://www.youtube.com/watch?v=nIH3i7fjd2U";
  bool isSwitched = false;

  var firebaseUser = FirebaseAuth.instance.currentUser;

  var docData;
  getData(String uid) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        //اجيب بيانات دوكيمنت واحد فقط
        .collection('users')
        .doc(uid);
    //get will return docs Query snapshot
    await documentReference.get().then((value) {
      //value.data is the full fields for this doc
      if (value.exists) {
        setState(() {
          docData = value.data();
          print(docData);
          // print(value.id);
          print('=============');
        });
      } else {}
    });
  }

  @override
  void initState() {

      getData(firebaseUser!.uid);
      super.initState();

  }
   getCurrentUser(){
    //هادا المتغير يحفظ لي معلومات اخر يوزر عمل تسجيل دخول في التطبيق
    // عشان استخدم معلوماته دام لسه ما سوا تسجيل خروج
    var currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser!.email);
    return currentUser ;

  }
  // @override
  // void initState(){
  //
  //     getCurrentUser();
  //     super.initState();
  //
  // }

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
        leading: IconButton(
            icon: Icon(Icons.search, color: white),
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => CartScreen()));
              showSearch(context: context, delegate: DataSearch());
            }),

        //shape:,

        // elevation: 0,
        toolbarHeight: 110,
        backgroundColor: basicColor,
        title: Text(
          'Home Page',
          style: TextStyle(color: white, fontSize: 30),
        ),
        centerTitle: true,

        //actions: <Widget>[
        //   IconButton(
        //       icon: Icon(Icons.shopping_cart_outlined, color: white),
        //       onPressed: () {
        //         Navigator.push(context,
        //             MaterialPageRoute(builder: (context) => CartScreen()));
        //       }),
        //   IconButton(
        //       icon: Icon(Icons.notifications, color: white),
        //       onPressed: () {}),
        //   Switch(
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
        //   ),
        // ],
      ),

      endDrawer: MainDrawer(
        username: getCurrentUser().toString().isNotEmpty?docData['username']: Text('Guest'),
        useremail: getCurrentUser().toString().isNotEmpty?docData['email']: Text('...'),
      ),

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
              SizedBox(
                height: 5,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     margin: EdgeInsets.all(5),
              //     height: 50,
              //     decoration: BoxDecoration(color: white, boxShadow: [
              //       BoxShadow(
              //         color: Color(0xFF90A4AE),
              //         offset: Offset(5, 10),
              //         blurRadius: 8,
              //       )
              //     ]),
              //     child: ListTile(
              //       leading: Icon(
              //         Icons.search,
              //         size: 50,
              //         color:Color(0xFF90A4AE),
              //
              //       ),
              //       title: TextField(
              //         decoration: InputDecoration(
              //           hintText: "Find what you want..",
              //           hintStyle: TextStyle(
              //               color:Color(0xFF90A4AE),
              //               fontWeight: FontWeight.bold),
              //           border: InputBorder.none,
              //         ),
              //         onTap: () {
              //
              //         },
              //       ),
              //     ),
              //   ),
              // ),
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
              SizedBox(
                height: 20,
              ),

              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Press below for Latest Products! ',
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

class DataSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.cancel_outlined),
        //محتوى الكلام الي كتبته ف البحث بينحفظ في متغير اسمه كويري معرف مسبقا داخل هذا الكلاس
        onPressed: () {
          //when clicked it will be empty again.
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        // Navigator.of(context).pop();  نفس الي تحتها
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("$query");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List filtirnames = names
        .where(
          (element) => element.contains(query),
        )
        .toList();
    //الاقتراحات الي تظهر تحت محل البحث
    return ListView.builder(
        itemCount: query == "" ? names.length : filtirnames.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {
              query = query == "" ? names[i] : filtirnames[i];
              showResults(context);
            },
            child: Container(
                padding: EdgeInsets.all(20),
                child: query == ""
                    ? Text(
                        '${names[i]}',
                        style: TextStyle(fontSize: 20),
                      )
                    : Text('${filtirnames[i]}',
                        style: TextStyle(fontSize: 20))),
          );
        });
  }

  List names = ['moham', 'basel', 'ruba', 'batool'];
}
