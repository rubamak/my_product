//ربا مرت من هناا
import 'dart:isolate';

//ruba love samaha
import 'package:flutter/material.dart'; //for design

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:my_product/dummy_data.dart';
import 'package:my_product/json_test.dart';
import 'package:my_product/pages/Registration_page.dart';
import 'package:my_product/pages/add_product.dart';
import 'package:my_product/pages/cart.dart';

import 'package:my_product/pages/drawer_section_pages/single_chat_screen.dart';
import 'package:my_product/pages/drawer_section_pages/favorite_screen.dart';
import '../pages/families_screen.dart';
import 'package:my_product/pages/home.dart';
import 'package:my_product/pages/infro_screen.dart';
import 'package:my_product/pages/landing_page.dart';
import 'package:my_product/pages/login.dart';
import 'package:my_product/pages/my_products_page.dart';
import '../pages/product_details_latest_products.dart';
import '../pages/product_detail_screen.dart';
import 'package:my_product/pages/products_screen.dart';
import 'package:my_product/pages/signup_page.dart';
import 'package:my_product/pages/taps_screen.dart';
import '../providers/my_provider.dart';

import 'color/my_colors.dart';
import 'modules/products.dart';
import '../pages/category_screen.dart';
import 'package:provider/provider.dart';





// runApp is library function
// here where program start

 Future<void> main()  async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   runApp(

         ChangeNotifierProvider(
         create: (_)=> Products(),
          child: MyApp(),
         ),
   );



}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();

  List <Product> _favoriteProducts = [];

  void _toggleFavorites (int productId){
     final productExistingIndex = _favoriteProducts.indexWhere((product){
       return product.productId== productId;
     });
     if(productExistingIndex >= 0){
       setState(() {
         _favoriteProducts.removeAt(productExistingIndex);
       });
     } else{
       setState(() {
         _favoriteProducts.add(
             DUMMY_PRODUCTS.firstWhere((product) => product.productId ==productId));
       }); }
  }
  bool _isProductFavorite(int productId){
    return _favoriteProducts.any((product) => product.productId == productId);
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(  //GetMaterialApp
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor:basicColor,

        ),

          //home:
        initialRoute:'/' ,
        routes: {

          '/': (context) => MyProductsPage(),//Registartion(),//MyProductsPage(),//SignupPage(),//MyProductsPage(),//Login(),HomePage()//this line is same -->  home:  HomePage(),
         TapsScreen.routeName: (context) => TapsScreen(_favoriteProducts),
          CategoryScreen.routeName: (context)=> CategoryScreen(),
          FamiliesScreen.routeName: (context) => FamiliesScreen(),
          ProductsScreen.routeName: (context) => ProductsScreen(),
          SingleChatScreen.routeName: (context) => SingleChatScreen(),
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(_toggleFavorites,_isProductFavorite),
          //FavoriteScreen.routeName: (context) => FavoriteScreen(_favoriteProducts),

        },

        );
  }
}

/*class AppIsolate extends StatefulWidget {
  const AppIsolate({Key? key}) : super(key: key);

  @override
  _AppIsolateState createState() => _AppIsolateState();
}

class _AppIsolateState extends State<AppIsolate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test isolate"),

      ),
      body: Center(
        child: TextButton(
          onPressed: () {
             //print("main isolate");

           // compute( blockApp, 2); or Isolate.spawn(blockApp,2)
          },
          child: Text('click here '),
        ),
      ) ,
    );
    }

}

blockApp(int sec){

  print("begin");

  sleep(Duration(seconds: sec));

  print("end");
}*/
