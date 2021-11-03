import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/modules/product.dart';
import 'package:my_product/pages/home_page.dart';
import 'package:my_product/pages/my_products_page.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class AddProduct extends StatefulWidget {
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var productController = TextEditingController()..text = "";

  var descriptionController = TextEditingController()..text = "";

  var priceController = TextEditingController()..text = "";


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var firebaseUser =  FirebaseAuth.instance.currentUser;

  Builder buildDialogItem(BuildContext context, String text, IconData icon, ImageSource src) {
    return Builder(
      builder: (innerContext) => Container(
        decoration: BoxDecoration(
          color: basicColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: white,
          ),
          title: Text(text),
          onTap: () {
            getImage(src);
           // Get.back();

            // context.read<Products>().getImage(src);
            //البوب هادي رح تحذف مربع الدايالوج فقط لانه كونتيمست مخصص
            Navigator.of(innerContext).pop();
          },
        ),
      ),
    );
  }

  File image;

  String imageUrl;

  Future getImage(src) async {
    var img = await ImagePicker().pickImage(source: src);
     setState(() {
    image = File(img.path);
     });
  }

  @override
  Widget build(BuildContext context) {
    //String _image = Provider.of<Products>(context, listen: true).image;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          toolbarHeight: 100,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
            // color: black,
          ),
          title: Padding(
            padding: EdgeInsets.only(top: 1),
            child: Text(
              "Add Product",
              style: TextStyle(color: black, fontSize: 25),
            ),
          ),
          backgroundColor: basicColor,
        ),
        body: Container(
            color: basicColor,
            child: Container(
                height: MediaQuery.of(context).size.height - 100,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(120),
                    )),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding:  EdgeInsetsDirectional.only(start: 100,top: 0,bottom: 20),
                          child: Text("Choose your product image:"),),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: InkWell(
                            onTap: () {
                              var alertDialog = AlertDialog(
                                title: Text("Choose picture from:"),
                                content: Container(
                                  height: 150,
                                  child: Column(
                                    children: [
                                      Divider(color: black,),
                                      buildDialogItem(context, "Camera", Icons.add_a_photo_outlined, ImageSource.camera),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      buildDialogItem(context, "Gallery", Icons.image_outlined, ImageSource.gallery),
                                    ],
                                  ),
                                ),
                              );
                              showDialog(context: context, builder: (BuildContext ctx) => alertDialog);
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white38,
                              radius: 90,
                              child: ClipRRect(
                                clipBehavior: Clip.antiAlias,
                                child: (image != null)
                                    ? Image.file(image)
                                    : Image.asset(
                                  "images/noProduct.jpg"
                                ),
                              ),
                            ),
                          ),
                        ),

                        TextFormField(
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
                          validator: (val) {
                            if (val.toString().length < 5 || val == null) {
                              return " enter name ";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            labelText: "add description",
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          controller: descriptionController,
                          validator: (val) {
                            if (val.toString().length < 10 || val == null) {
                              return " enter description between 10-20 char";
                            } else {
                              return null;
                            }
                            ;
                          },
                          // onSaved: (value) {
                          // },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
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
                          validator: (val) {
                            if (val == null ) {
                              return "enter a  vaild price please";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: double.infinity,
                          child:ElevatedButton(
                              child: Text("Add Your product"),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(10),
                                primary: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),),
                              onPressed:  () {
                                addProduct();
                              }

                          ),
                        ),


                      ],
                    ),
                  ),
                )
            )
        )
        //
        //
        //
        //         child: ElevatedButton(
        //           child: Text("Choose Product Image"),
        //           style: ElevatedButton.styleFrom(
        //             padding: EdgeInsets.all(10),
        //             primary: Theme
        //                 .of(context)
        //                 .primaryColor,
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(25),
        //             ),
        //           ),
        //           onPressed: () {
        //             var alertDialog = AlertDialog(
        //               title: Text("Choose picture from:"),
        //               content: Container(
        //                 height: 150,
        //                 child: Column(
        //                   children: [
        //                     Divider(color: black,),
        //                     buildDialogItem(
        //                         context, "Camera", Icons.add_a_photo_outlined,
        //                         ImageSource.camera),
        //                     SizedBox(height: 10,),
        //                     buildDialogItem(
        //                         context, "Gallery", Icons.image_outlined,
        //                         ImageSource.gallery),
        //                   ],
        //                 ),
        //               ),
        //             );
        //             showDialog(context: context,
        //                 builder: (BuildContext ctx) => alertDialog);
        //           },
        //         ),
        //       ),
        //       SizedBox(
        //         height: 10,
        //       ),
        //
        //       Consumer <Products>(
        //         builder: (ctx, value, _) =>
        //             Container(
        //               width: double.infinity,
        //               child: ElevatedButton(
        //                 child: Text("Add Product"),
        //                 style: ElevatedButton.styleFrom(
        //                   padding: EdgeInsets.all(10),
        //                   primary: Theme
        //                       .of(context)
        //                       .primaryColor,
        //                   shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(25),
        //                   ),),
        //                 onPressed: () async {
        //                   if (_image.isEmpty) {
        //                     Fluttertoast.showToast(
        //                       msg: "please select an image !",);
        //                   } else if (productController.text == "" ||
        //                       descriptionController.text == "" ||
        //                       priceController.text == "" ||
        //                       categoryController.text == "" ||
        //                       familyNameController.text == "") {
        //                     Fluttertoast.showToast(
        //                       msg: "please fill the fields",);
        //                   }
        //                   else {
        //                     try {
        //                       value.add(
        //                         title: productController.text,
        //                         category: categoryController.text,
        //                         familyName: familyNameController.text,
        //                         desc: descriptionController.text,
        //                         price: double.parse(priceController.text),
        //                       );
        //
        //                       value.deleteImage(); //عشان احذف الصورة المخزنة قببل اصفرهاا
        //                       //await Navigator.pushReplacement(ctx, MaterialPageRoute(builder: (ctx)=> MyProductsPage()));
        //                       Fluttertoast.showToast(
        //                         msg: "product added Successfully.",);
        //                       Navigator.pop(context);
        //                     } catch (e) {
        //                       Fluttertoast.showToast(
        //                           msg: "please enter valid price");
        //                       print(e);
        //                     }
        //                   }
        //                 },
        //               ),
        //             ),
        //       )
        //     ]),
        //),

        );
  }

  Future addProduct()async{

    var productRef = await FirebaseFirestore.instance.collection('products');
    var productId = await FirebaseFirestore.instance.collection("familiesStores").doc().id;

    if (_formKey.currentState.validate() && image !=null) {
      _formKey.currentState.save();
      //=====put image in the storage
      var storageImage = FirebaseStorage.instance.ref().child(image.path);
      var task = storageImage.putFile(image);
      // take image url to put it in fire store
      imageUrl = await (await task.whenComplete(() => null)).ref.getDownloadURL();
      //========end image section

try {
  productRef.doc(productId).set({
    'uid': firebaseUser.uid,
    'family store id': datafamily.docs[0].data()['family id'],
    'category name': datafamily.docs[0].data()['category name'],
    'price': int.parse(priceController.text),
    'category id': datafamily.docs[0].data()['category id'],
    'product id' : productId,
    'product name': productController.text,
    'product description': descriptionController.text,
    'image product': imageUrl,
  }).then((value) {
    print(' product added');
    Fluttertoast.showToast(msg: 'product added',);
     Get.off(()=> HomePage());
    //Navigator.of(context).pop();
  });
}catch(e){
  print("error when adding product: $e");

}


    } else {
      AwesomeDialog(context: context, title: "Something wrong !",
        body: Text("invalid data in your fields",style: TextStyle(color: black),),)
        ..show();
      print(" values not valid" );
    }


  }
var docData;
  QuerySnapshot <Map<String, dynamic>> datafamily ;
  getFamilyData(String uid) async {
    //اجيب بيانات دوكيمنت واحد فقط
    //get will return docs Query snapshot
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) async{
      //value.data is the full fields for this doc
      if (value.exists) {
        setState(() {
          docData = value;
          print(docData.id);
        });
        await FirebaseFirestore.instance.collection('familiesStores')
            .where('uid',isEqualTo: docData.id).get().then((doc) {
          if(doc != null && doc.docs.isEmpty == false){
            setState(() {
              datafamily =doc;


            });

          }
        });
      } else {}
    });

  }
  @override
  void initState() {
    getFamilyData(firebaseUser.uid);
    super.initState();
  }
}
