


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'dart:io';
import 'dart:ui';
import 'package:my_product/modules/product.dart';
import 'package:my_product/pages/my_products_page.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {

  final String desc;
  ProductDetails(this.desc);


  @override
  Widget build(BuildContext context) {
    // List <Product> prodList =
    //     Provider.of<Products>(context,listen: true).productsList;
    // هذا عنصر واحد
    //     var filteredItem = prodList.firstWhere(
    //             (element) => element.description == desc, orElse: null);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        elevation: 0,
        // leading:  IconButton(
        //   icon: Icon(Icons.arrow_back_ios),
        //   onPressed: () {
        //     Navigator.pop(context,filteredItem.productName);
        //   },
        //   color: Colors.white,
        // ),

        title:
        //filteredItem == null ? null:
        Padding(
          padding: EdgeInsets.only(top: 1),
          child: Text(
            "filteredItem.productName" ,
            style: TextStyle(
              color: black,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
        ),
        backgroundColor: basicColor,
        toolbarHeight: 80,

      ),
      body:
      //filteredItem == null ? null :
        ListView(
          children: <Widget>[
            SizedBox(height: 20,),
      Container(
        height: MediaQuery.of(context).size.height - 180,
        width:75 ,
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(100),bottomRight:Radius.circular(150),)),

        child: Column(
          children: [
           // buildContainer(
                //filteredItem.productImage,filteredItem.description,context)
              // Container(
              //   height: MediaQuery.of(context).size.height - 700,
              //   child: Hero(
              //     tag :filteredItem.productId,
              //     child: Image.file(File(filteredItem.productImage),fit: BoxFit.fill,),
              //   ),
              // ),

            SizedBox(height: 20,),
          //  buildCard(filteredItem.productName,filteredItem.categoryName,filteredItem.familyName,filteredItem.description,filteredItem.price),


          ],


      ),
      )
          //  buildContainer(filteredItem.productImage,filteredItem.description),

          ],
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //Provider.of<Products>(context,listen: false).delete(filteredItem.productImage);
          //يحذق لي الصفحة ويرجع لورا طبعا ويروح للصفحة الي قبلها ويحذف هناك
         // Navigator.pop(context,filteredItem.description);
        },
        backgroundColor: basicColor,
        child: Icon(Icons.delete,color: black,),
      ),


    );
  }

  Container buildContainer(String image, String desc ,BuildContext context){
    return Container(
      child: Center(
        child: Hero(
          tag :desc,
          child: Image.file(File(image),fit: BoxFit.contain,
            height: MediaQuery.of(context).size.height - 500,
           width:MediaQuery.of(context).size.width  ,
              ),
        ),
      ),
    );

  }

  Card buildCard(String title, String category,String familyName,String desc,double price ){
    return Card(
      elevation: 20,
      margin: EdgeInsets.all(15),
      child: Padding(
        padding:  EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,color:black),
            ),
            Divider(color: black,),
            Text(
              desc, style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,color:black),
              textAlign: TextAlign.justify,
            ),
            Divider(color: black,),
            Text(
              "$price SR",
              style: TextStyle(

                  fontSize: 20,color:black,
                  fontWeight: FontWeight.bold),
            ),
            Divider(color: black,),
            Text(
              familyName,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,color:black),
            ),
            Divider(color: black,),
            Text(
              category,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,color:black),
            ),
            Divider(color: black,),



          ],
        ),
      ),
    );
  }
}
