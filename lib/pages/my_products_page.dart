import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/modules/products.dart';
import 'package:my_product/pages/add_product.dart';
import 'package:my_product/pages/drawer_section_pages/single_chat_screen.dart';
import 'package:my_product/pages/drawer_section_pages/favorite_screen.dart';
import 'package:my_product/pages/product_detail_screen.dart';
import 'package:my_product/pages/product_details.dart';
import 'package:my_product/pages/product_details_latest_products.dart';
import 'package:provider/provider.dart';
class MyProductsPage extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    List <Product> productList = Provider.of<Products>(context,listen: true).productsList;



   /* Widget detailCard(String title,String desc,double price,String categoryName,String image,ctx){

      return TextButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (_)=> ProductDetails(desc)))
              .then((value) => Provider.of<Products>
            (context,listen: false).delete(value));
        },
        child: Column(
          children: [
            SizedBox(height: 5,),
            Card(
              color: grey,
              elevation: 10,
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 3,
                      child: Container(
                       // color: black,
                        padding: EdgeInsets.only(right: 10),
                        width: 200,
                        child: Hero(
                          tag: desc,
                          child: Image.file(File(image),fit: BoxFit.fill,),
                        ),
                      )
                  ),

                  Expanded(

                    flex: 2,
                    child: Column(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10,),
                        Text(
                          title,
                          style: TextStyle(
                            color: white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        ),
                        Divider(color: white,),

                    Text(
                      categoryName,
                      style: TextStyle(
                          color: white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),

                        Divider(color: white,),
                    Container(
                      width: 200,
                      child: Text(
                        desc, style: TextStyle(
                          color: white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.justify,
                        maxLines: 4,
                      ),
                    ),

                        Divider(color: white,),
                        Text(
                          "$price SR",
                          style: TextStyle(
                              color: white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),

                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                  Expanded(flex: 1, child:  Icon(Icons.arrow_forward_ios),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }*/

   /* Widget buildPositioned( String title , String desc, String category,double p){
      var descreption = desc.length >30 ? desc.replaceRange(20,desc.length, '...' ): desc ;

      return Positioned(
        right: 10,
          bottom: 10,
          child: Container(
            width: 180,
            color: Colors.black38,
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),

            child: Text(
              "$title\n$descreption\n$p SR \n $category",
              style: TextStyle(fontSize: 20,color: white),
              softWrap: true,
              maxLines: 8,
              overflow: TextOverflow.fade,
            ),
          )
      );
    }*/

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        elevation: 0,
        title: Text("My Products "),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: productList.isEmpty ?
          Container(
            color: basicColor,
            child: Container(
              height: MediaQuery.of(context).size.height - 100,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(120),
                  )
              ),

              child: Center(
                child: Text("No Products added,",style: TextStyle(fontSize: 40),),),
            ),
          )
          :Container(
             color: basicColor,
          child: Container(
            height: MediaQuery.of(context).size.height - 100,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(120),
                )
            ),

            child: ListView(

                //     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                //     maxCrossAxisExtent: 500,
                //   mainAxisSpacing: 10,
                //   crossAxisSpacing: 10,
                //   childAspectRatio: 2,
                // ),
        children: productList
                  .map((item) => Container(
            child: Builder(

                // builder: (ctx)=> detailCard(  هذه الطريقة ما رضيت تتطلع لي الصورة
                //     item.productName,item.description,
                //     item.price, item.categoryName, item.categoryName,item.imageUrl),)
                builder: (ctx)=>
                      TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (_)=>
                                  ProductDetails(item.description))).
                              // value here is item with specific desc that will delete using delete method
                          then((desc) => Provider.of<Products>
                            (context,listen: false).delete(desc));
                        },
                        child: Column(
                         children: [
                        SizedBox(height: 50,),
                        Card(
                          shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20))
                          ),
                        color: grey,
                        elevation: 0,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                flex: 2,
                                child: Container(
                                  // color: black,
                                  padding: EdgeInsets.only(right: 10),
                                  width: 130,
                                  child: Hero(
                                    tag: item.description,
                                    child: Image.file(File(item.productImage),fit: BoxFit.cover,
                                     // height: MediaQuery.of(context).size.height - 800,
                                      // width:MediaQuery.of(context).size.width -250 ,
                                    ),
                                  ),
                                )
                            ),

                            Expanded(

                              flex: 3,
                              child: Column(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 10,),
                                  Text(
                                    item.productName,
                                    style: TextStyle(
                                        color: white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Divider(color: white,),

                                  Text(
                                    item.categoryName,
                                    style: TextStyle(
                                        color: white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),

                                  Divider(color: white,),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      item.description, style: TextStyle(
                                        color: white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.justify,
                                      maxLines: 2,
                                    ),
                                  ),

                                  Divider(color: white,),
                                  Text(
                                    "${item.price} SR",
                                    style: TextStyle(
                                        color: white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),

                                  SizedBox(height: 10,),
                                ],
                              ),
                            ),
                            Expanded(flex: 2,

                              child:  Icon(Icons.arrow_forward_ios,color: white,),
                            )
                          ],
                        ),
                    ),
                ]
                ),
                      )
        ),
                  ),
        ).toList()
      ),
          ),

          ),





      floatingActionButton: Container(
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: basicColor,
        ),
        child: TextButton.icon(
              label: Text("add product",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: white),),
              icon: Icon(Icons.add,color: white,),
                onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> AddProduct())),

            )
      ),
    );
  }
}
