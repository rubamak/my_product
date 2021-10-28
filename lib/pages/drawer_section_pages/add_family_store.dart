

// ignore_for_file: prefer_const_constructors, unused_local_variable, await_only_futures, avoid_function_literals_in_foreach_calls, unnecessary_string_interpolations

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_product/modules/category.dart';
import 'package:my_product/modules/product.dart';
import 'package:provider/provider.dart';
import 'package:my_product/widgets/category_item.dart';
import 'dart:io';
import 'package:get/get.dart';


import 'package:my_product/modules/category.dart';

class AddFamilyStore extends StatefulWidget{
  @override
  State<AddFamilyStore> createState() => _AddFamilyStoreState();
}

class _AddFamilyStoreState extends State<AddFamilyStore> {
  var  familyStoreNameController = TextEditingController()..text="";
  var descriptionController = TextEditingController()..text= "";
  var categoryController = TextEditingController()..text= "";




  // Builder buildDialogItem (BuildContext context,String text,IconData icon, ImageSource src ){
  //   return Builder(
  //     builder: (innerContext)=>
  //         Container(
  //           decoration: BoxDecoration(
  //             color: basicColor,
  //             borderRadius: BorderRadius.circular(15),
  //           ),
  //           child: ListTile(
  //             leading: Icon(icon,color: white,),
  //             title: Text(text),
  //             onTap: (){
  //
  //               context.read<Products>().getImage(src) ;
  //               //البوب هادي رح تحذف مربع الدايالوج فقط لانه كونتيمست مخصص
  //               //Navigator.of(innerContext).pop();
  //               Get.back();
  //
  //             },
  //           ),
  //         ),
  //   );
  //
  // }
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   File image;
  String imageUrl;
  Future getImage() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(img.path);
    });
  }

  var categoryChooseId ;
  var categoryChooseName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add new productive family store",
          style: TextStyle(color: white, fontSize: 13),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(

        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
     
        child:
        Form(
          key: _formKey,
          child: ListView(
              children: [
                SizedBox(height: 60,),
                Padding(padding: EdgeInsets.all(20),
                child: InkWell(
                  onTap: getImage,
                  child: CircleAvatar(
                    backgroundColor: Colors.white38,
                      radius: 90,
                    child: ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      child: (image != null)
                          ? Image.file(image)
                          : Image.network('https://previews.123rf.com/images/thesomeday123/thesomeday1231712/thesomeday123171200009/91087331-default-avatar-profile-icon-for-male-grey-photo-placeholder-illustrations-vector.jpg'),
                    ),
                    //Image.network(imageUlr!):
                    //FileImage(image!) :
                   // NetworkImage("https://previews.123rf.com/images/thesomeday123/thesomeday1231712/thesomeday123171200009/91087331-default-avatar-profile-icon-for-male-grey-photo-placeholder-illustrations-vector.jpg") as ImageProvider  ,
                    ),
                ),
                ),
                TextFormField(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: "Enter family Store Name:",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,color: basicColor),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  controller: familyStoreNameController,
                  validator: (val){
                    if ( val.isEmpty){
                      return" add family store name";}
                    else  if(val.length < 2){
                   return" Store name is too short";}
                    else{return null;}
                  },
                  keyboardType: TextInputType.text,

                ),
                SizedBox(height: 20,),
                TextFormField(
                  style: TextStyle(fontWeight: FontWeight.bold,),
                  decoration: InputDecoration(
                    labelText: "add description of your family",
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,color: basicColor),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),

                  keyboardType: TextInputType.multiline,
                  controller: descriptionController,
                  validator: (val){
                    if(val.isEmpty){
                      return"add decsription please!";
                    }else if(val.length < 5){
                      return"the description is too short";
                    }else{return null ;}
                  },

                ),
                SizedBox(height: 20,),
                 // familyType(),
          StreamBuilder<QuerySnapshot< Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance.collection('categories').snapshots(),
                  //هادا الشرط زبط .where('name',isEqualTo: "Food")
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("Loading..");
              } else {
                List<DropdownMenuItem<String>> categoryList = [];
                for (int i = 0; i < snapshot.data.docs.length; i++) {
                  DocumentSnapshot<Map<String, dynamic>> snap = snapshot.data.docs[i];

                  categoryList.add(
                      DropdownMenuItem(
                    child: Text(snap.data()['name'].toString(),
                    ),
                    value:  "${snap.id}",
                  ));
                }
                return DropdownButton<String>(
                  //icon: Icon(Icons.arrow_drop_down_rounded),
                  iconEnabledColor: Colors.black,
                  iconDisabledColor: Colors.grey,
                  iconSize: 5.0,
                  items: categoryList,
                  onChanged: (val) async{

                    setState(() async{

                      var zg = await FirebaseFirestore.instance
                          .collection("categories").doc(categoryChooseId).get();
                      categoryChooseId = val ;

                        print(zg['name']);
                        categoryChooseName= zg['name'];
                          //categoryChooseId = zg['id'];


                    });




                     // categoryChooseName= snap.data()['name'];
                     //   print(categoryChooseId);
                     //  print(categoryChooseName);
                    print("==============================");

                    },

                  value: categoryChooseId , // Selected Value From DropDownMenu Is Stored Here
                  isDense: false,
                  isExpanded: false,
                  hint:Text("choose your store category"),

                );
              }
            },

          ),

                SizedBox(height: 20,),
                // Container(
                //   width: double.infinity,
                //   child:  ElevatedButton(
                //     child: Text("Add Family Image"),
                //     style: ElevatedButton.styleFrom(
                //       padding: EdgeInsets.all(10),
                //       primary: Theme.of(context).primaryColor,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(25),
                //       ),
                //     ),
                //     onPressed: () {
                //       var alertDialog = AlertDialog(
                //         title: Text("Choose picture from:"),
                //         content: Container(
                //           height: 150,
                //           child: Column(
                //             children: [
                //               Divider(color: black,),
                //               buildDialogItem(context, "Camera", Icons.add_a_photo_outlined, ImageSource.camera),
                //               SizedBox(height: 10,),
                //               buildDialogItem(context, "Gallery", Icons.image_outlined, ImageSource.gallery),
                //             ],
                //           ),
                //         ),
                //       );
                //       showDialog(context: context, builder: (BuildContext ctx) => alertDialog);
                //     },
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                      Container(
                        width: double.infinity,
                        child:ElevatedButton(
                          child: Text("Add Your Store"),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10),
                            primary: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),),
                          onPressed:  () {
                            addFamilyStore();
                          }

                        ),
                      ),

   ]
  )
      ),
                        )
    );
  }


  Future addFamilyStore()async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    var categoryRef = await FirebaseFirestore.instance.collection('categories');
    var familiesstores = await FirebaseFirestore.instance.collection('familiesStores');

    if (_formKey.currentState.validate() && image !=null) {
      _formKey.currentState.save();
      //=====put image in the storage
      var storageImage = FirebaseStorage.instance.ref().child(image.path);
      var task = storageImage.putFile(image);
      // take image url to put it in fire store
      //مو راضي يزبط معايا اني اخد الصورة من الستورج واحطها ف الفاير ستور
     imageUrl = await (await task.whenComplete(() => null)).ref.getDownloadURL();
     //========end image section

     // if(firebaseUser!.uid == familiesstoresRef){}
      ///////////////////////////
      //print(familiesstores.doc().id);
          familiesstores.add({
        'uid': firebaseUser.uid,
            'family id':familiesstores.id,
        'category name':categoryChooseName,
        'family store name': familyStoreNameController.text,
        'category id': categoryChooseId,
        'store description': descriptionController.text,
        'image family store': imageUrl,
      }).then((value) {
        print('${value} store added');
        Fluttertoast.showToast(msg: 'store added');
        Get.back();
        //Navigator.of(context).pop();
      });


  } else {
      AwesomeDialog(context: context, title: "Something wrong !",
        body: Text("invalid data in your fields"),)
        ..show();
      print(" values not valid");
    }
  }
  
 

 Widget familyType() {
  return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance.collection('categories').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text("Loading..");
                    } else {
                      List<DropdownMenuItem<String>> productsToList = [];
                      for (int i = 0; i < snapshot.data.docs.length; i++) {
                        DocumentSnapshot<Map<String, dynamic>> snap = snapshot.data.docs[i];
                        productsToList.add(DropdownMenuItem(
                          child: Text(snap.data()['name'].toString(),
                               ),

                          value:
                          "${snap.id}",
                        ));
                      }
                      return DropdownButton<String>(
                        iconEnabledColor: Colors.white,
                        iconDisabledColor: Colors.white,
                        iconSize: 5.0,
                        items: productsToList,
                        onChanged: (val) async{
                          setState(() {
                            categoryChooseId = val ;
                            //categoryChooseName = snapshot.data.docs;
                          });
                          print(categoryChooseId);
                        },
                        value: categoryChooseId , // Selected Value From DropDownMenu Is Stored Here
                        
                        isDense: false,
                        isExpanded: false,
                        hint:Text("choose your store category"),
                       
                      );
                    }
                  },
                );
          //  DropdownSearch<String>(
          //     mode: Mode.MENU,
          //     label: "choose your store category:",

          //     items: 
          //     // categoriesNamesList.map((element) {
          //     //   print(element);

          //     // }).toList()
          //     // categoriesNamesList.map((String dropdownItem) {

          //     //} ).toList(),
          //     [ "Food","Drinks","Clothes","Homemade","Digital Services" ],
          //     selectedItem: categoryChoose,
          //     onChanged: (val){
          //       setState(() {
          //         categoryChoose = val!;
          //         print(categoryChoose);

          //       });
          //     },
          //     validator: (val) => val!.isEmpty ? "choose category please": null,


          // );

 }
}