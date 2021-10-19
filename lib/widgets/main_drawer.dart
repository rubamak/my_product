

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/pages/Registration_page.dart';
import 'package:my_product/pages/add_product.dart';
import 'package:my_product/pages/cart.dart';
import 'package:my_product/pages/category_screen.dart';

import 'package:my_product/pages/drawer_section_pages/add_new_family.dart';
import 'package:my_product/pages/drawer_section_pages/add_family_store.dart';

import 'package:my_product/pages/drawer_section_pages/single_chat_screen.dart';
import 'package:my_product/pages/drawer_section_pages/favorite_screen.dart';
import 'package:my_product/pages/drawer_section_pages/helping_section.dart';
import 'package:my_product/pages/home_page.dart';
import 'package:my_product/pages/login.dart';
import 'package:my_product/pages/my_family_store_page.dart';
import 'package:my_product/pages/taps_screen.dart';

class MainDrawer extends StatefulWidget {



  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool islogin = false ;
var user = FirebaseAuth.instance.currentUser;
   bool checkLogin(){
      if(user == null ){

        islogin = false;
      }else {

        islogin = true;
      }
      return islogin;
    }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          //header
          Column(
            children: [
              const Text(
                "Welcome to ",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
              ),
              const Text(
                "My Product",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
              ),
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50),bottomRight:Radius.circular(50),),
                  color: Color(0xFF90A4AE),

                ),

                //بعدين حيصير ياخد الايميل من الداتا بيز لما ينضافو

                accountName: Text(""),
                accountEmail:checkLogin() ? Text(user!.email.toString()): Text("Guest"),//فيه ايرور انه لما يسجل خروج يصير نل هنا وصفحة حمرا

                currentAccountPicture: GestureDetector(
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.grey),
                  ),
                ),
              ),

            ],
          ),

          //body-----------------------------------------

          buildListTile("Home Page", Icons.home_outlined,(){Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> HomePage()));} ),
          buildListTile("My Profile", Icons.person_outline_sharp,(){}),
          buildListTile('Categories', Icons.dashboard_outlined,(){Navigator.pushReplacementNamed(context, TapsScreen.routeName);}),
          checkLogin() ? buildListTile("My Profile", Icons.person_outline_sharp,(){}): SizedBox(height: 0,),
          buildListTile('Categories', Icons.dashboard_outlined,(){Navigator.pushNamed(context, TapsScreen.routeName);}),
          buildListTile('My Orders', Icons.shopping_cart_outlined,(){}),
          // buildListTile('Favourites Products', Icons.favorite_outline,(){Navigator.pushNamed(context, FavoriteScreen.routeName);}),
          buildListTile('My Chats', Icons.chat_outlined,(){  }),
          const Divider(color: Colors.black54),//0xffFFBCBC الللون القديم لو تبيه ياربا
          //هنا مفروض اضيف الفايل او اللسته من الصفحه الجديده اللي ضفتها add_new_family
          buildListTile('Add Store',Icons.add,(){Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> addNewFamily()));}),
          buildListTile('Settings', Icons.settings,(){}),
          buildListTile('Enjoy to Help you', Icons.help_outline_outlined,(){Navigator.push(context, MaterialPageRoute(builder: (context)=> HelpingSection()));}),


          const Divider(color: Colors.black54),//0xffFFBCBC الللون القديم لو تبيه ياربا
          checkLogin()? buildListTile('My Store',Icons.add,(){Navigator.push(context,MaterialPageRoute(builder: (context)=> MyFamilyStorePage()));}): SizedBox(height: 0,),
          buildListTile('Settings', Icons.settings,(){}),
          buildListTile('Enjoy to Help you', Icons.help_outline_outlined,(){Navigator.push(context, MaterialPageRoute(builder: (context)=> HelpingSection()));}),


           Divider(color: Colors.black54),//0xffFFBCBC الللون القديم لو تبيه ياربا
           checkLogin()? SizedBox(height: 0,): MaterialButton(
            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));},
            child: const Text("Login", style: TextStyle(color: Colors.white),),
            color: Color(0xFF90A4AE),
          ),
           checkLogin() ? MaterialButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
            },
            color: Color(0xFF90A4AE),
            child: const Text(
              " Sign Out",
              style: TextStyle(color: Colors.white),
            ),
          ) : Text("Login to gain more features",textAlign: TextAlign.center,),
        ],
      ),
    );



  }
  // use voidCallback for use void method that not using ()=>
  Widget buildListTile(String title, IconData icon ,VoidCallback onTapHandler, ){
    return ListTile(
      onTap: onTapHandler,
      title: Text(title, style: TextStyle(color: basicColor),
      ),
      leading: Icon(icon, color: grey),
    );
  }



}