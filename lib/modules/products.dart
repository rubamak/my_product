
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Product {
    final
    String productId;
 final String familyId;
 //final int categoryId;
   final String productName;
  final String categoryName;
  String familyName;
   final double price;
   //final File image ;
   final String productImage;
  final String description;



  Product({
    required this.productId,
     required this.familyId,
    //required this.categoryId,
     required this.categoryName,

     required this.productName,
     required this.familyName,
        required this.price,
       required this.productImage,

       required this.description,});

}
//name of provider is Products
class Products with ChangeNotifier{
  List <Product> productsList = [];
       String image='';

  // void didChangeDependencies() {
  //
  // }

  void add ({required String  title,required String desc ,  required String category,
    required String familyName , required double price,}  )
        {
      //هذه ريل تايم داتا بيز
    // DatabaseReference _ref = FirebaseDatabase.instance.reference()
    //      .child("products"); //عملت ريفرنس في مكان في الداتا بيز
    //
    // final String url = "https://flutter-project-9f14f-default-rtdb.firebaseio.com/products.json" ;
    //
    // http.post(Uri.parse( url) , body: json.encode({ //  احط بيانات في داتا بيس
    //
    //   "title": title,
    //   "description": desc,
    //   "category": category,
    //   "familyName": familyName,
    //   "price": price,
    //   "image": "",
    //
    // })).then((res) {
    //   print( json.decode(res.body));

          CollectionReference product = FirebaseFirestore.instance.collection("products");

          productsList.add(
          Product(
              productId: "1",//int.parse(json.decode(res.body)['name']),
              familyId: "2",
              categoryName: category,
              familyName: familyName,
              productName: title,
              price: price,
              productImage: image,
              description: desc
          ));

     product.add({
       "product name": title ,
       "price" : price,
       "family name": familyName,
       "description": desc,
       "category": category



     });
      notifyListeners();
    // });
    }

  void delete (String desc){
    productsList.removeWhere((element) => element.description == desc);

    print("item deleted");
    notifyListeners();
  }
  void deleteImage(){
    image= '';
  }

  Future getImage(ImageSource src) async {
    //final picker = ImagePicker();
    final pickedImage = await ImagePicker().pickImage(source: src);// pickImage(source:src) == getImage(source:src)
    if(pickedImage!= null){
        image = pickedImage.path;
        notifyListeners();
        print("image select");
    }else{
      print("no image selected");
    }
  }

}
