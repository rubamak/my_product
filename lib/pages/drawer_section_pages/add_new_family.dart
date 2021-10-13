import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_product/modules/products.dart';
import 'package:provider/provider.dart';
import 'package:my_product/widgets/category_item.dart';
import 'package:select_form_field/select_form_field.dart';




class addNewFamily extends StatelessWidget{

   var  familyNameControler = TextEditingController()
     ..text="";
    var descriptionController = TextEditingController()
      ..text= "";
    var categoryController = TextEditingController()
      ..text= "";

    // var imageController = TextEditingController()..text ="";

    //static var category = {"Choose one","Food", "Drink", "Clothes", "Home Made", "Digital Services"};

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


    @override
    Widget build(BuildContext context) {
      String _image = Provider.of<Products>(context, listen: true).image;
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
          ListView(
              children: [
                TextField(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: "Enter family Name:",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,color: basicColor),
                      borderRadius: BorderRadius.circular(20.0),

                    ),
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  controller: familyNameControler,
                  keyboardType: TextInputType.text,

                ),
                SizedBox(height: 20,),
                TextField(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: "add description of your family",
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,color: basicColor),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  controller: descriptionController,

                  //   labelText: "what your category:",//here it must be a list
                  //   hintText: "Food,Drinks..",
                  //   labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  //   enabledBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(width: 2),
                  //     borderRadius: BorderRadius.circular(20.0),
                  //   ),
                  // ),
                  // keyboardType: TextInputType.text,
                  // controller: categoryController,

                ),
               SizedBox(height: 20,),
                Container(
                  child:
                    familyType(),


               ),
               //  SizedBox(height: 20),

                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  child:  ElevatedButton(
                    child: Text("Add Family Image"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      primary: Theme.of(context).primaryColor,
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
                              buildDialogItem(context, "Camera", Icons.add_a_photo_outlined, ImageSource.camera),
                              SizedBox(height: 10,),
                              buildDialogItem(context, "Gallery", Icons.image_outlined, ImageSource.gallery),
                            ],
                          ),
                        ),
                      );
                      showDialog(context: context, builder: (BuildContext ctx) => alertDialog);
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Consumer <Products>(
                  builder:(ctx,value,_)=>
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
                          onPressed: () async {

                            if (_image.isEmpty){
                              Fluttertoast.showToast(msg: "please select an image !",);
                            }else if(familyNameControler.text==""){
                              Fluttertoast.showToast(msg: "please enter family name !",);}
                            else if(descriptionController.text==""){
                              Fluttertoast.showToast(msg: "please enter a description !",);}
                            else if(categoryController.text==""){
                              Fluttertoast.showToast(msg: "please select your category !",);}

                            else{
                              try{
                                value.add(
                                  category: categoryController.text,
                                  desc: descriptionController.text, familyName: '', title: '', price: 0.0,
                                );

                                value.deleteImage();//عشان احذف الصورة المخزنة قببل اصفرهاا
                                //await Navigator.pushReplacement(ctx, MaterialPageRoute(builder: (ctx)=> MyProductsPage()));
                                Fluttertoast.showToast(msg: "product added Successfully.",);
                                Navigator.pop(context);


                              }catch(e){
                                Fluttertoast.showToast(msg: "please enter valid price");
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

 Widget familyType () {
    List categoryList =
     [ "Food","Drinks","Clothes","Homemade","Digital Services" ];
    String? categoryChoose;
  var valueChoose;
  return Container(
    child: valueChoose == categoryList[0]? null  :
    Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: white,width: 2)
      ),
      child: Column(
        children: [
         DropdownButton(

            borderRadius: BorderRadius.circular(20),
            hint: Text("select your Category:"),
            isExpanded: true,
            value: categoryChoose,
            onChanged: (newValue){
              categoryChoose = newValue as String?;},
           
            items: categoryList.map((catItem) {
              return DropdownMenuItem(

                value: catItem,
                child: Text(catItem),
                enabled: true,
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
 }


}