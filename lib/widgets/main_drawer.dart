
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/pages/category_screen.dart';
import 'package:my_product/pages/drawer_section_pages/profile_screen.dart';
import 'package:my_product/pages/drawer_section_pages/settings_page.dart';
import 'package:my_product/pages/chat/chat_rooms_screen.dart';
import 'package:my_product/pages/chat/single_chat_screen.dart';
import 'package:my_product/pages/drawer_section_pages/favorite_screen.dart';
import 'package:my_product/pages/drawer_section_pages/helping_section.dart';
import 'package:my_product/pages/home_page.dart';
import 'package:my_product/pages/login.dart';
import 'package:my_product/pages/drawer_section_pages/my_family_store_page.dart';
import 'package:my_product/pages/taps_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
  MainDrawer({
      this.username,
      this.useremail,
});

  String username;
  String  useremail ;

}


class _MainDrawerState extends State<MainDrawer> {

  bool islogin = false;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  bool checkLogin() {
    if (firebaseUser == null) {
      islogin = false;
    } else {
      islogin = true;
    }
    return islogin;
  }

var userEmail ;
  getSharedPreferences()async{
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    setState(() {
      userEmail = sharedpref.getString('email');
      // sharedpref.setString('email',);
      print(" shared get it ");
    });
  }




  @override

  Widget build(BuildContext context) {
    return Drawer(
      child:Container(
        color: white,
      child: ListView(
        children: <Widget>[
          //header
          Column(
            children: [
             SizedBox(height: 50),
                  Stack(
                    children:[
                      UserAccountsDrawerHeader(
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50),bottomRight:Radius.circular(50),),
                        color: basicColor,
                      ),
                      //بعدين حيصير ياخد الايميل من الداتا بيز لما ينضافو

                      accountName:
                      checkLogin() ? Text(widget.username,style: TextStyle(color:black)):
                      Text('Guest',style: TextStyle(color:black),),
                      accountEmail:
                      checkLogin()?
                      Text(widget.useremail,style: TextStyle(color: black),):Text('Mode',style: TextStyle(color: black),),
                      //فيه ايرور انه لما يسجل خروج يصير نل هنا وصفحة حمرا(ضبطت الايرور بنجاح )

                      currentAccountPicture: GestureDetector(
                        child:
                            //هنا كان في كمان كونست
                           checkLogin() ? CircleAvatar(
                            backgroundColor: white,
                            child: Icon(Icons.person, color: black),
                          ): SizedBox(height: 0,),


                      ),
                    ),
                      Positioned(top: 10,right: 20,left:100 ,bottom:20,child: Image.asset('images/myLogo.png')),

                    ]
                  ),

            ],
          ),

          //body-----------------------------------------

          buildListTile("Home Page", Icons.home_outlined,(){
            Get.off(()=> HomePage());} ),

          checkLogin() ? buildListTile("My Profile", Icons.person_outline_sharp,(){
            Get.to(()=> ProfileScreen());
          }): SizedBox(height: 0,),

          buildListTile('Categories', Icons.dashboard_outlined,(){Get.toNamed(CategoryScreen.routeName);}),
          checkLogin() ? buildListTile(' My Cart & Favorites', Icons.favorite_outline,(){
            Get.toNamed(TapsScreen.routeName); }): SizedBox(height: 0,),

          checkLogin() ? buildListTile('My Chats', Icons.chat_outlined,(){
            Get.off(()=> ChatRoomsScreen()
            ); }): SizedBox(height: 0,),
           Divider(color: Colors.black54),//0xffFFBCBC الللون القديم لو تبيه ياربا
          //هنا مفروض اضيف الفايل او اللسته من الصفحه الجديده اللي ضفتها add_new_family


          checkLogin() ?
          buildListTile('Own Store',Icons.add,(){
            Get.to(()=>MyFamilyStorePage());
            //Navigator.push(context,MaterialPageRoute(builder: (context)=> MyFamilyStorePage()));
            }):SizedBox(height: 0,),
          buildListTile('Settings', Icons.settings,(){ Get.to(()=> SettingsPage());}),
          buildListTile('Enjoy to Help you', Icons.help_outline_outlined,(){
                Get.to(()=> HelpingSection());
           // Navigator.push(context, MaterialPageRoute(builder: (context)=> HelpingSection()));
            }),
          const Divider(color: Colors.black54),//0xffFFBCBC الللون القديم لو تبيه ياربا
           checkLogin()? SizedBox(height: 0,): Padding(
             padding: const EdgeInsets.all(20.0),
             child: MaterialButton(
              onPressed: () {
               // Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
               //Get.to(Login());
               Get.to(()=> Login());
                },
               //هنا كمان شلت كونست
              child:  Text("Login", style: TextStyle(color: black),),
              color:basicColor,
          ),
           ),
           checkLogin() ? Padding(
             padding: const EdgeInsets.all(20.0),
             child: MaterialButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Fluttertoast.showToast(msg: 'you signed out!');
                //Navigator.of(context).pop();
                Get.back();
              },
              color: basicColor,
               //هنا كمان حذن كونست
              child: Text(
                " Sign Out",
                style: TextStyle(color: black),
              ),),
           ) : Text("Login to gain more features",textAlign: TextAlign.center,style: TextStyle(color: black),),
        ],
      ),
      ));

  }
  // use voidCallback for use void method that not using ()=>
  Widget buildListTile(String title, IconData icon ,VoidCallback onTapHandler, ){
    return ListTile(
      onTap: onTapHandler,
      title: Text(title, style: TextStyle(color: black),
      ),
      leading: Icon(icon, color: black),
    );
  }



}