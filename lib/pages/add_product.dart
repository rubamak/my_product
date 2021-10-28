import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/modules/product.dart';
import 'package:my_product/pages/home_page.dart';
import 'package:my_product/pages/my_products_page.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatelessWidget {
  var productController = TextEditingController()
    ..text = "";
  var descriptionController = TextEditingController()
    ..text = "";
  var priceController = TextEditingController()
    ..text = "";
  var categoryController = TextEditingController()
    ..text = "";
  var familyNameController = TextEditingController()
    ..text = "";

  // var imageController = TextEditingController()..text ="";

  //static var category = {"Choose one","Food", "Drink", "Clothes", "Home Made", "Digital Services"};

  Builder buildDialogItem(BuildContext context, String text, IconData icon,
      ImageSource src) {
    return Builder(
      builder: (innerContext) =>
          Container(
            decoration: BoxDecoration(
              color: basicColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: Icon(icon, color: white,),
              title: Text(text),
              onTap: () {
                context.read<Products>().getImage(src);
                //البوب هادي رح تحذف مربع الدايالوج فقط لانه كونتيمست مخصص
                Navigator.of(innerContext).pop();
              },
            ),
          ),
    );
  }


  @override
  Widget build(BuildContext context) {
    String _image = Provider.of<Products>(context, listen: true).image;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Product",
          style: TextStyle(color: white, fontSize: 15),
        ),
        backgroundColor: Theme
            .of(context)
            .primaryColor,
      ),
      body: Container(

        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        //child: Form(
        //key: _formKey,
        child:
        ListView(
            children: [
              TextField(
                style: TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: "Enter product Name:",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                controller: productController,
                keyboardType: TextInputType.text,

              ),
              SizedBox(height: 20,),
              TextField(
                style: TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: "add description",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2,),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                keyboardType: TextInputType.text,
                controller: descriptionController,
                // validator: (val) {
                //   if (val.toString().length > 10 || val == null) {
                //     return " enter description between 0-50 char";
                //   } else {
                //     return null;
                //   }
                //   ;
                // },
                // onSaved: (value) {
                //   _productData['description'] = value!;
                //   print(_productData['description']);
                // },
              ),
              SizedBox(height: 20,),
              TextField(
                style: TextStyle(fontWeight: FontWeight.bold),

                decoration: InputDecoration(
                  labelText: "Enter Price",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),

                keyboardType: TextInputType.number,
                controller: priceController,
                // validator: (val) {
                //   if (val == null) {
                //     return "enter a price please";
                //   } else {
                //     return null;
                //   }
                //   ;
                // },
              ),
              SizedBox(height: 20,),

              TextField(
                style: TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: "what your category:",
                  hintText: "Food,Drinks..",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                keyboardType: TextInputType.text,
                controller: categoryController,
                // validator: (val) {
                //   if (val == null) {
                //     return "enter a price please";
                //   } else {
                //     return null;
                //   }
                //   ;
                // },
              ),
              SizedBox(height: 20),
              TextField(
                style: TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: "Enter family Name:",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                controller: familyNameController,
                keyboardType: TextInputType.text,

              ),
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                // child: TextField(
                //   decoration: InputDecoration(
                //     labelText: "image url",
                //     hintText: "please paste your image url here",
                //   ),
                //   controller:  imageController ,
                //
                // ),
                child: ElevatedButton(
                  child: Text("Choose Product Image"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10),
                    primary: Theme
                        .of(context)
                        .primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    var alertDialog = AlertDialog(
                      title: Text("Choose picture from:"),
                      content: Container(
                        height: 150,
                        child: Column(
                          children: [
                            Divider(color: black,),
                            buildDialogItem(
                                context, "Camera", Icons.add_a_photo_outlined,
                                ImageSource.camera),
                            SizedBox(height: 10,),
                            buildDialogItem(
                                context, "Gallery", Icons.image_outlined,
                                ImageSource.gallery),
                          ],
                        ),
                      ),
                    );
                    showDialog(context: context,
                        builder: (BuildContext ctx) => alertDialog);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Consumer <Products>(
                builder: (ctx, value, _) =>
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text("Add Product"),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10),
                          primary: Theme
                              .of(context)
                              .primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),),
                        onPressed: () async {
                          if (_image.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "please select an image !",);
                          } else if (productController.text == "" ||
                              descriptionController.text == "" ||
                              priceController.text == "" ||
                              categoryController.text == "" ||
                              familyNameController.text == "") {
                            Fluttertoast.showToast(
                              msg: "please fill the fields",);
                          }
                          else {
                            try {
                              value.add(
                                title: productController.text,
                                category: categoryController.text,
                                familyName: familyNameController.text,
                                desc: descriptionController.text,
                                price: double.parse(priceController.text),
                              );

                              value.deleteImage(); //عشان احذف الصورة المخزنة قببل اصفرهاا
                              //await Navigator.pushReplacement(ctx, MaterialPageRoute(builder: (ctx)=> MyProductsPage()));
                              Fluttertoast.showToast(
                                msg: "product added Successfully.",);
                              Navigator.pop(context);
                            } catch (e) {
                              Fluttertoast.showToast(
                                  msg: "please enter valid price");
                              print(e);
                            }
                          }
                        },
                      ),
                    ),
              )
            ]),
      ),
    );





  }
}
