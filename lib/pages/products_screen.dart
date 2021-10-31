import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/dummy_data.dart';
import 'package:my_product/widgets/main_drawer.dart';
import 'package:my_product/widgets/product_item.dart';

import 'families_screen.dart';

class ProductsScreen extends StatelessWidget {

  static const routeName = '/theProducts-screen';

  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute
        .of(context)
        .settings
        .arguments as Map<String, Object>;
    final familyId = routeArg['id'];
    final familyName = routeArg['name'];

    final products = DUMMY_PRODUCTS;
    //     .where((product) {
    //   return product.familyId == familyId;
    // }).toList();


    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color:black),
          elevation: 0,
          leading:  IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop(familyName);
            },
            color: white,
          ),

          title: Padding(
            padding: EdgeInsets.only(top: 1),
            child: Text("Products of ${familyName.toString()}",
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
        //endDrawer: MainDrawer(),
        backgroundColor: basicColor,
      body: ListView(
          children: <Widget>[
            SizedBox(height: 20,), //between them
            Container(
              height: MediaQuery.of(context).size.height - 180,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(100),
                    //bottomRight:Radius.circular(150)
                    )),

              child: ListView(
                primary: false,
                padding: EdgeInsets.only(left: 25, right: 25),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 45),
                    child: Container(

                      height: MediaQuery
                          .of(context)
                          .size
                          .height - 300,
                      child:
                      ListView(
                        children: products.map((productItem) =>
                            ProductItem(
                                productId: productItem.productId,
                                productName: productItem.productName,
                                productImage: productItem.productImage,
                                price: productItem.price,
                                description: productItem.description)
                        ).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]
      ),
    );
  }}