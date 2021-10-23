

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_product/modules/category.dart';
import 'package:my_product/modules/product.dart';
import 'package:provider/provider.dart';
import 'package:my_product/widgets/category_item.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:my_product/modules/category.dart';




class AddFamilyStore extends StatefulWidget{
  @override
  State<AddFamilyStore> createState() => _AddFamilyStoreState();
}

class _AddFamilyStoreState extends State<AddFamilyStore> {
  var  familyStoreNameController = TextEditingController()..text="";

  var descriptionController = TextEditingController()..text= "";

  var categoryController = TextEditingController()..text= "";

  Builder buildDialogItem (BuildContext context,String text,IconData icon, ImageSource src ){
    return Builder(
      builder: (innerContext)=>
          Container(
            decoration: BoxDecoration(
              color: basicColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: Icon(icon,color: white,),
              title: Text(text),
              onTap: (){

                context.read<Products>().getImage(src) ;
                //البوب هادي رح تحذف مربع الدايالوج فقط لانه كونتيمست مخصص
                Navigator.of(innerContext).pop();


              },
            ),
          ),
    );

  }
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add new productive family",
          style: TextStyle(color: white, fontSize: 15),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        //child: Form(
        //key: _formKey,
        child:
        Form(
          key: _formKey,
          child: ListView(
              children: [
                SizedBox(height: 100,),
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
                    if ( val!.isEmpty){
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
                    if(val!.isEmpty){
                      return"add decsription please!";
                    }else if(val.length < 5){
                      return"the description is too short";
                    }else{return null ;}
                  },

                ),
                SizedBox(height: 20,),
                  familyType(),
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
                // SizedBox(
                //   height: 10,
                // ),

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
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FirebaseFirestore.instance.collection('familiesStores')
          .add({
        'uid': firebaseUser!.uid,
        'family store name': familyStoreNameController.text,
        'category': categoryChoose,
        'store description': descriptionController.text,
      }).then((value) {
        print('store added');
        Fluttertoast.showToast(msg: 'store added');
        Navigator.of(context).pop();
      //return
      });

        // return familiesStores.add({
        //   'family store name': familyStoreNameController.text,
        //   'store description': descriptionController.text,
        //   'category': categoryChoose,
        // }).
        //then((value) =>
          //  Navigator.pop(context),
           // Fluttertoast.showToast(msg: "family store added !"),
        //);


  } else {
      AwesomeDialog(context: context, title: "Something wrong !",
        body: Text("invalid data in your fields "),)
        ..show();
      print(" values not valid");
    }
  }
 static var categoryChoose ="";
 Widget familyType() {
  return
           DropdownSearch<String>(
              mode: Mode.MENU,
              label: "choose your store category:",
              items: [ "Food","Drinks","Clothes","Homemade","Digital Services" ],
              selectedItem: categoryChoose,
              onChanged: (val){
                setState(() {
                  categoryChoose = val!;
                  print(categoryChoose);

                });
              },
              validator: (val) => val!.isEmpty ? "choose category please": null,


          );

 }
}