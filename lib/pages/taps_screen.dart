

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/modules/product.dart';
import 'package:my_product/pages/category_screen.dart';
import 'package:my_product/pages/drawer_section_pages/favorite_screen.dart';
import 'package:my_product/pages/home_page.dart';
import 'package:my_product/widgets/main_drawer.dart';

class TapsScreen extends StatefulWidget {

  final List<Product> favoriteProducts;

  TapsScreen(this.favoriteProducts);




  @override
  _TapsScreenState createState() => _TapsScreenState();

  static const routeName = '/taps_screen';

}

class _TapsScreenState extends State<TapsScreen> {


    List<Map<String, Object>> _pages ;

  int _selectedPageIndex =0;

  void initState(){
    _pages = [
      {'page': CategoryScreen(),
        'title': 'Categories',
      },
      {'page': FavoriteScreen(widget.favoriteProducts),
        'title': 'Favorites List',}];

    if (firebaseUser != null && firebaseUser.uid.isNotEmpty){
      print( "user not null=================");
      getUserData(firebaseUser.uid);}
    super.initState();


  }
  void _selectSection(int value) {
    setState(() {
      _selectedPageIndex = value;
    });
  }
    User firebaseUser = FirebaseAuth.instance.currentUser;

    DocumentSnapshot<Map<String, dynamic>> docData;
    var username; // for display to user
    var useremail;

    getUserData(String uid) async {
      //اجيب بيانات دوكيمنت واحد فقط
      //get will return docs Query snapshot
      await FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) async {
        //value.data is the full fields for this doc
        if (value.exists) {
          setState(() {
            docData = value;
            useremail = docData['email'];
            username = docData['username'];
          });
          print(docData['uid']);
          print(docData['username']);
          print(docData['email']);
          print('======================');
        } else {
          //fetchSpecifiedFamilyStore();
        }
      });
    }

  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context).settings.arguments;


    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        elevation: 0,
        leading: IconButton(
          onPressed: ()=> Navigator.of(context).pop() ,
          icon: Icon(Icons.arrow_back_ios),
        ),


        title: Padding(
          padding: EdgeInsets.only(top: 1),

          child: Text((_pages[_selectedPageIndex]['title']).toString(),


      style: TextStyle(
              color: black,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),

          ),
        ),
        backgroundColor: Color(0xFF90A4AE),
        toolbarHeight: 80,
      ),
     //endDrawer: MainDrawer(),

      backgroundColor: Color(0xFF90A4AE),
      endDrawer: MainDrawer(username: username, useremail: useremail,),

      body:ListView(
          children: <Widget>[
            SizedBox(height: 20,), //between them
            Container(
              height: MediaQuery.of(context).size.height - 180,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(100),bottomRight:Radius.circular(150),)),


              child: ListView(
                primary: false,
                padding: EdgeInsets.only(left: 25, right: 25),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 45),
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height - 300,
                      child: Container(decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(200),bottomRight:Radius.circular(150),)),
                          child: (_pages[_selectedPageIndex]['page']) as Widget,

                      ),
                    ),
                  ),
                ],
              ),
            )
          ]
      ),


      // Container(decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.only(topLeft: Radius.circular(200),bottomRight:Radius.circular(150),)),
      //   child: (_pages[_selectedPageIndex]['page']) as Widget,
      // ),


      bottomNavigationBar: BottomNavigationBar(

        elevation: 0,
        selectedFontSize: 20,
        selectedItemColor: black ,
       selectedLabelStyle: TextStyle(fontWeight: FontWeight.w900),
       // unselectedItemColor: white,
        currentIndex: _selectedPageIndex,
        onTap: _selectSection,
        backgroundColor: Color(0xFF90A4AE),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              label: "Categories"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_border_outlined),
              label: "Favorites"

          ),
        ],
      ),
       // drawer:  MainDrawer(),
    );
  }


}
