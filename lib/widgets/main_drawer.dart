
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/pages/Registration_page.dart';
import 'package:my_product/pages/add_product.dart';
import 'package:my_product/pages/categories_pages/accessories.dart';
import 'package:my_product/pages/category_screen.dart';
import 'package:my_product/pages/drawer_section_pages/settings_page.dart';
import 'package:my_product/pages/drawer_section_pages/single_chat_screen.dart';
import 'package:my_product/pages/drawer_section_pages/favorite_screen.dart';
import 'package:my_product/pages/drawer_section_pages/helping_section.dart';
import 'package:my_product/pages/home_page.dart';
import 'package:my_product/pages/login.dart';
import 'package:my_product/pages/my_family_store_page.dart';
import 'package:my_product/pages/taps_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
  MainDrawer({
      this.username,
      this.useremail,
});

  String   username;
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



  // var docData;
  // getData(String uid) async {
  //   DocumentReference documentReference = FirebaseFirestore.instance
  //   //اجيب بيانات دوكيمنت واحد فقط
  //    .collection('users').doc(uid);
  //   //get will return docs Query snapshot
  //   await documentReference.get().then((value) {
  //     //value.data is the full fields for this doc
  //     if(value.exists) {
  //       docData = value.data();
  //       print(docData);
  //       // print(value.id);
  //       print('=============');
  //     }else{ }
  //   });
  //   return docData;
  // }
  //======================= how to use where
  /*
  CollectionReference userRef = FirebaseFirestore.instance.collection("users);
  await usersRef.where("the field",isEqualTo: " value " ).get().then((value) {
  //ممكن كمان where("name", whereIn/whereNotIn: [القيم عبارة عن مصفوفة ]
  value.docs.forEach((element){
  });
  });
*/
  //var username;
  //رح يجيب لستة فيها كل الدكيمونت الموجودة في الكولكيشن
  // getData2() async {
  //   //create collection
  //   CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
  //   //استعلام كامل لهذا الكولكيشن
  //   QuerySnapshot querySnapshot = await usersRef.get();
  //   //all the docs in list
  //   List <dynamic> listDocs = querySnapshot.docs;
  //   // for each document get the data for specific field
  //   listDocs.forEach((element) {
  //     print(element.data()['email']);
  //     print(element.data()['username']);
  //     print("================================");
  //   });
  // }
  //==========================OR===========
  /* FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        print(element.data()['first Name']);
      });
    });
  }*/


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
             // SizedBox(height: 100,child: Image.asset('images/logo.png'),),
              Padding(

                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                    onTap: () async {
                      },
                    child: SizedBox(height: 100,child: Image.asset('images/myLogo.png'),)),
              ),

              UserAccountsDrawerHeader(
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50),bottomRight:Radius.circular(50),),
                  color: basicColor,

                ),

                //بعدين حيصير ياخد الايميل من الداتا بيز لما ينضافو

                accountName:
                checkLogin() ? Text(widget.username,style: TextStyle(color:black)):
                Text('Guest',style: TextStyle(color:black),),
                    // FutureBuilder(
                    //   future: getData(firebaseUser!.uid),
                    //   builder: (_,AsyncSnapshot snapshot){
                    //     if(snapshot.connectionState == ConnectionState.waiting){
                    //       return SizedBox(height: 0,);
                    //     }
                    //       return Text(
                    //           "Account Name: " + snapshot.data['username']);
                    //
                    //   },)


                accountEmail:
                checkLogin()?
                Text(widget.useremail):Text('Mode',style: TextStyle(color: black),),
                //فيه ايرور انه لما يسجل خروج يصير نل هنا وصفحة حمرا(ضبطت الايرور بنجاح )

                currentAccountPicture: GestureDetector(
                  child:
                      //هنا كان في كمان كونست
                     CircleAvatar(
                      backgroundColor: white,
                      child: Icon(Icons.person, color: black),
                    ),


                ),
              ),
            ],
          ),

          //body-----------------------------------------

          buildListTile("Home Page", Icons.home_outlined,(){
           // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> HomePage()));
            Get.off(()=> HomePage());
            } ),
          checkLogin() ? buildListTile("My Profile", Icons.person_outline_sharp,(){}): SizedBox(height: 0,),
          buildListTile('Categories & Favorites', Icons.dashboard_outlined,(){
            //Navigator.pushNamed(context, TapsScreen.routeName);
            Get.toNamed(TapsScreen.routeName);
            }),
          // buildListTile('Favourites Products', Icons.favorite_outline,(){Navigator.pushNamed(context, FavoriteScreen.routeName);}),
          buildListTile('My Chats', Icons.chat_outlined,(){  }),
          const Divider(color: Colors.black54),//0xffFFBCBC الللون القديم لو تبيه ياربا
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