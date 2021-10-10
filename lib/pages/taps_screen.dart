

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/modules/products.dart';
import 'package:my_product/pages/category_screen.dart';
import 'package:my_product/pages/drawer_section_pages/favorite_screen.dart';
import 'package:my_product/pages/home.dart';
import 'package:my_product/widgets/main_drawer.dart';

class TapsScreen extends StatefulWidget {

  final List<Product> favoriteProducts;

  TapsScreen(this.favoriteProducts);




  @override
  _TapsScreenState createState() => _TapsScreenState();

  static const routeName = '/taps_screen';

}

class _TapsScreenState extends State<TapsScreen> {


   late List<Map<String, Object>> _pages ;

  int _selectedPageIndex =0;

  void initState(){
    _pages = [
      {'page': CategoryScreen(),
        'title': 'Categories',
      },
      {'page': FavoriteScreen(widget.favoriteProducts),
        'title': 'Favorites List',}];
    super.initState();


  }
  void _selectSection(int value) {
    setState(() {
      _selectedPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context)!.settings.arguments;


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading:  IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
           // Navigator.of(context).popAndPushNamed(_pages[_selectedPageIndex]['title'].toString());
          },
          color: Colors.white,
        ),

        title: Padding(
          padding: EdgeInsets.only(top: 1),

          child: Text((_pages[_selectedPageIndex]['title']).toString(),


      style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),

          ),
        ),
        backgroundColor: Color(0xFF90A4AE),
        toolbarHeight: 80,
      ),
      endDrawer: MainDrawer(),

      backgroundColor: Color(0xFF90A4AE),

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
        selectedItemColor: white ,
        unselectedItemColor: black,
        currentIndex: _selectedPageIndex,
        onTap: _selectSection,
        backgroundColor: Color(0xFF90A4AE),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              title:Text( "Categories")

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_border_outlined),
              title: Text("Favorites")

          ),
        ],
      ),
        drawer: const MainDrawer(),
    );
  }


}
