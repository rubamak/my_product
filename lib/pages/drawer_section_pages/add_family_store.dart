


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
import 'package:my_product/modules/product.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:get/get.dart';



import '../home_page.dart';

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


  var categoryChooseId;
  var categoryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        title: Text(
          "Add new productive family store",
          style: TextStyle(color: black, fontSize: 13),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        color: white,

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
                    backgroundColor: Colors.white,
                      radius: 90,
                    child: ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      child: (image != null)
                          ? Image.file(image)
                          : Image.asset("images/noFamily.jpg"),
                    ),
                    ),
                ),
                ),
                Padding(
                  padding:  EdgeInsetsDirectional.only(start: 100,top: 0,bottom: 20),
                  child: Text("Choose your store image",style: TextStyle(color: black),),
                ),
                TextFormField(
                  style: TextStyle(color:black,fontWeight: FontWeight.bold),
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
                  style: TextStyle(fontWeight: FontWeight.bold,color: black),
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
                 // the drop down button
                 familyType(),

                SizedBox(height: 20,),
                      Container(
                        width: double.infinity,
                        child:ElevatedButton(
                          child: Text("Add Your Store",style: TextStyle(color: black)),
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
    //var categoryRef = await FirebaseFirestore.instance.collection('categories');
    var familiesStoresRef = await FirebaseFirestore.instance.collection('familiesStores');
    var familyId = await FirebaseFirestore.instance.collection("familiesStores").doc().id;
    if (_formKey.currentState.validate() && image !=null) {
      _formKey.currentState.save();
      //=====put image in the storage
      var storageImage = FirebaseStorage.instance.ref().child(image.path);
      var task = storageImage.putFile(image);
      // take image url to put it in fire store
      //مو راضي يزبط معايا اني اخد الصورة من الستورج واحطها ف الفاير ستور
      imageUrl = await (await task.whenComplete(() => null)).ref.getDownloadURL();
      //========end image section
      try {
        familiesStoresRef.doc(familyId).set({
          'uid': firebaseUser.uid,
          'family id': familyId,
          'category name': categoryName,
          'family store name': familyStoreNameController.text.trim(),
          'category id': categoryChooseId,
          'store description': descriptionController.text,
          'image family store': imageUrl,
        }).then((value) {
          print(' store added');
          Fluttertoast.showToast(msg: 'store added',);
          Get.off(() => HomePage());
          //Navigator.of(context).pop();
        });
      } catch (e) {

      }
    } else {
      AwesomeDialog(context: context, title: "Something wrong !",
        body: Text("invalid data in your fields", style: TextStyle(color: black),),)
        ..show();
      print(" values not valid");
    }
  }

  
 

 Widget familyType() {
  return
    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection("categories").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading..");
        } else {
          List<DropdownMenuItem> categoryList = [];
          for (int i = 0; i < snapshot.data.docs.length; i++) {
            DocumentSnapshot<Map<String, dynamic>> snap = snapshot.data.docs[i];
            categoryList.add(
                DropdownMenuItem<String>(
                  child: Text(snap.data()['name'].toString(),
                  ),
                  value: "${snap.id}",

                ));
          }
          return DropdownButton(
            iconEnabledColor: black,
            iconDisabledColor: black,
            iconSize: 5,
            items: categoryList,
            onChanged: (value) async{
              categoryChooseId = value;
              await FirebaseFirestore.instance.collection('categories').doc(categoryChooseId)
                  .get().then((value) {
                categoryName = value['name'];
              });
              setState(() {

              });
              print(categoryName);
              print(categoryChooseId);
            },
            value: categoryChooseId, // Selected Value From DropDownMenu Is Stored Here
            isDense: false,
            isExpanded: false,
            hint: new Text("Choose your category",style: TextStyle(color: black)),
          );
        }
      },
    );
 }
}