//ربا مرت من هناا وسماحه كمان

//ruba love samaha
import 'package:flutter/material.dart'; //for design
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_product/pages/Registration_page.dart';
import 'package:my_product/pages/drawer_section_pages/helping_section.dart';
import 'package:my_product/pages/drawer_section_pages/settings_page.dart';
import 'package:my_product/pages/chat/single_chat_screen.dart';
import 'package:my_product/pages/drawer_section_pages/favorite_screen.dart';
import 'package:my_product/pages/drawer_section_pages/my_family_store_page.dart';
import 'package:my_product/widgets/main_drawer.dart';
import 'package:my_product/widgets/product_item.dart';
import '../pages/families_screen.dart';
import 'package:my_product/pages/home_page.dart';
import 'package:my_product/pages/landing_page.dart';
import '../pages/product_details_latest_products.dart';
import 'package:my_product/pages/products_screen.dart';
import 'package:my_product/pages/taps_screen.dart';
import 'color/my_colors.dart';
import '../pages/category_screen.dart';

// runApp is library function
// here where program start

 void main()  async {
  //يتاكد من عملية التهيئة تمت عشان يشغل البرنلمج
   WidgetsFlutterBinding.ensureInitialized();
   //يتاكد من اتصال مع الفاير بيس
   await Firebase.initializeApp();

   runApp(

         //ChangeNotifierProvider(
         //create: (_)=> Products(),
          //child:
          MyApp(),
        // ),
   );



}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();

  List <String> _favoriteProducts = [];

  //void _toggleFavorites (int productId){
     // final productExistingIndex = _favoriteProducts.indexWhere((product){
     //   return product.productId== productId;
     // });
  //    if(productExistingIndex >= 0){
  //      setState(() {
  //        _favoriteProducts.removeAt(productExistingIndex);
  //      });
  //    } else{
  //      setState(() {
  //        // _favoriteProducts.add(
  //        //     DUMMY_PRODUCTS.firstWhere((product) => product.productId ==productId));
  //      }); }
  // }
  // bool _isProductFavorite(int productId){
  //   return _favoriteProducts.any((product) => product.productId == productId);
  // }


  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      //MaterialApp
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor:basicColor,
          cardColor: white,
          iconTheme: IconThemeData(color: black),

          backgroundColor: black,
          //brightness: Brightness.light,
          // primaryColorDark: ,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: black,
          ),
        ),


          //home:
        initialRoute:'/' ,
        getPages: [
          GetPage(name: '/', page:()=> LandingPage()),
          GetPage(name: TapsScreen.routeName,  page:()=> TapsScreen(
              //_favoriteProducts
          )),
          GetPage(name: CategoryScreen.routeName,  page:()=> CategoryScreen()),
          GetPage(name: FamiliesScreen.routeName, page: ()=>FamiliesScreen()),
          GetPage(name: ProductsScreen.routeName, page: ()=>ProductsScreen()),
          //GetPage(name: SingleChatScreen.routeName, page: ()=>  SingleChatScreen()),
              //_toggleFavorites,_isProductFavorite

          //GetPage(name: FavoriteScreen.routeName, page: FamiliesScreen(_favoriteProducts))



        ],

        // routes: {

        //   '/': (context) => LandingPage(),//MyProductsPage(),//,//MyProductsPage(),//SignupPage(),//MyProductsPage(),//Login(),HomePage()//this line is same -->  home:  HomePage(),
        //  TapsScreen.routeName: (context) => TapsScreen(_favoriteProducts),
        //   CategoryScreen.routeName: (context)=> CategoryScreen(),
        //   FamiliesScreen.routeName: (context) => FamiliesScreen(),
        //   ProductsScreen.routeName: (context) => ProductsScreen(),
        //   SingleChatScreen.routeName: (context) => SingleChatScreen(),
        //   ProductDetailScreen.routeName: (context) => ProductDetailScreen(_toggleFavorites,_isProductFavorite),
        //   //FavoriteScreen.routeName: (context) => FavoriteScreen(_favoriteProducts),

        // },
        );
  }
}


