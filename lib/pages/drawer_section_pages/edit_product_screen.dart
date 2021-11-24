import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:my_product/pages/home_page.dart';

class EditProductScreen extends StatefulWidget {
  // const EditProductScreen({Key key}) : super(key: key);
  final DocumentSnapshot<Map<String, dynamic>> selectedProduct;
  bool isLoading = false;

  EditProductScreen({
    this.selectedProduct,
  });

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  CollectionReference productRef = FirebaseFirestore.instance.collection('products');

  var docData; // for printing
  var username; // for display to user
  var userEmail;
  var productName, description, price;
 // String image;

  getProduct() async {
    //اجيب بيانات دوكيمنت واحد فقط
    DocumentReference productDoc = FirebaseFirestore.instance.collection('products').doc(widget.selectedProduct.id);
    //get will return docs Query snapshot
    await productDoc.get().then((value) {
      //value.data is the full fields for this doc
      if (value.exists) {
        setState(() {
          docData = value.data();
          productName = docData['product name'];
          description = docData['product description'];
          price = docData['price'];
         // image = docData['image product'];
        });
      } else {}
    });
  }

  @override
  void initState() {
    getProduct();
    super.initState();
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              //Navigator.of(context).pop();
              Get.back();
            },
            color: black,
          ),
          title: Padding(
            padding: EdgeInsets.only(top: 1),
            child: Text(
              "Edit Product",
              style: TextStyle(
                color: black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          backgroundColor: basicColor,
          toolbarHeight: 80,
        ),
        backgroundColor: basicColor,
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('products').doc(widget.selectedProduct.id).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height - 120,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        //bottomRight: Radius.circular(90),
                      )),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height - 120,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        //bottomRight: Radius.circular(90),
                      )),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ));
            } else {
              return Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height - 120,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                      //bottomRight: Radius.circular(90),
                    )),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: [

                        SizedBox(
                        height: 200,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("enter new product name:"),
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.black54),
                        decoration: InputDecoration(

                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2, color: basicColor),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelStyle: TextStyle(color: black),
                          hintText: productName,
                          hintStyle: TextStyle(fontWeight: FontWeight.w900, color: black, fontStyle: FontStyle.italic),

                        ),
                        keyboardType: TextInputType.name,
                        cursorColor: black,
                        // controller: _firstNameController,
                        validator: (val) {
                          if (val.length < 3) {
                            return " please enter longer name :(";
                          } else if (val == docData['product name']) {
                            return " same old product name ";
                          }
                          ;
                        },
                        onSaved: (value) {
                          productName = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("enter new description name:"),
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.black54),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2, color: basicColor),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelStyle: TextStyle(color: black),
                          hintText: description,
                          hintStyle: TextStyle(fontWeight: FontWeight.w900, color: black, fontStyle: FontStyle.italic),

                        ),
                        keyboardType: TextInputType.multiline,
                        cursorColor: black,
                        // controller: _lastNameController,
                        validator: (val) {
                          if (val.length < 20) {
                            return " please enter longer description :(";
                          } else if (val == docData['product description']) {
                            return " same old description ";
                          }
                          ;
                        },
                        onSaved: (value) {
                          description = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("enter new price :"),
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.black54),
                        decoration: InputDecoration(
                          // labelText: "Enter username :",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2, color: basicColor),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelStyle: TextStyle(color: black),
                          hintText: "$price",
                          hintStyle: TextStyle(fontWeight: FontWeight.w900, color: black, fontStyle: FontStyle.italic),

                        ),
                        keyboardType: TextInputType.number,
                        cursorColor: black,
                        //controller: _userNameController,
                        validator: (val) {
                          if(val.isEmpty){
                            return " enter please";
                          }else if (!val.contains(RegExp(r'[0-9]'))) {
                            return " you should enter numbers ";
                          } else if (val.contains('!') || val.contains('@') || val.contains('#'))
                            return " you should enter numbers only ";
                        },
                        onSaved: (value) {
                          price = value;
                        },
                      ),
                      SizedBox(height: 40,),
                          if(widget.isLoading)
                            Center(child: CircularProgressIndicator(),),
                          if(!widget.isLoading)
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                      TextButton.icon(
                      label: Text("update", style: TextStyle(fontSize: 20, color: black, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        updateProduct();
                      },
                      icon : Icon(Icons.edit_outlined, size: 25, color: black,)
                      ),
                    TextButton.icon(
                    label: Text("delete", style: TextStyle(fontSize: 20, color: black, fontWeight: FontWeight.bold),),
                    onPressed: () {
                      deleteProduct();
                    },
                    icon: Icon(Icons.delete_outline, size: 25, color: black,))

                ],)

            ],
            ),
            ),
            ),
            );
            //Center(child: Text(snapshot.data['last name']));
            }
          },
        ));
  }

  //Widget productInfoToEdit(BuildContext context) {}


  Future updateProduct() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState.validate()) {
      print("updated failed");
      AwesomeDialog(body: Text("please fill the fields with new data"));
      setState(() {
        widget.isLoading = false ;
      });
    } else {
      try{
        final snackBar = SnackBar
          (duration: Duration(seconds: 2), content: Text(" product info is updated ",
          style: TextStyle(color: white, fontSize: 15),), backgroundColor: black,);
        _formKey.currentState.save();
        // updateProduct();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
         Get.off(()=> HomePage());
      productRef.doc(widget.selectedProduct.id).update({
        'product name': productName.trim(),
        'product description': description.trim(),
        'price': double.parse(price.trim()),
      }).then((value) {
        print("product updated");

      });
        setState(() {
          widget.isLoading = true ;
        });


      }catch(e){
          print("Error:$e");
          setState(() {
            widget.isLoading = false ;
          });

      }
}

}

  Future deleteProduct()async{
    FocusScope.of(context).unfocus();
      //
      // print("updated failed");
      // AwesomeDialog(body: Text("please fill the fields with new data"));
      //
      // setState(() {
      //   widget.isLoading = false ;
      // });

      try{
        final snackBar = SnackBar
          (duration: Duration(seconds: 2), content: Text(" product is deleted ",
          style: TextStyle(color: white, fontSize: 15),), backgroundColor: black,);


        // updateProduct();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Get.off(()=> HomePage());


        productRef.doc(widget.selectedProduct.id).delete();

        setState(() {
          widget.isLoading = true ;
        });


      }catch(e){
        print("Error:$e");
        setState(() {
          widget.isLoading = false ;
        });

      }
    }

}
