import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/pages/product_details_latest_products.dart';


class LatestProducts extends StatefulWidget {
  const LatestProducts({Key key}) : super(key: key);

  @override
  _LatestProductsState createState() => _LatestProductsState();
}

class _LatestProductsState extends State<LatestProducts> {


  var product_list = [
    {
      "name": "Fatah",
      "picture": "images/products/f.png",
      "owner name": "Happy making",
      "category": "Food",
      "price": 20,
    },
    {
      "name": "Painted Cup",
      "picture": "images/products/hand.jpg",
      "owner name": "Happy making 2 ",
      "category": "Handmade",
      "price": 18,
    },
    {
      "name": "Frappe",
      "picture": "images/products/ice.jpg",
      "owner name": "Happy making 3",
      "category": "Beverages",
      "price": 15,
    },
    {
      "name": "Waffle",
      "picture": "images/products/waff.png",
      "owner name": "Happy making",
      "category": "Food",
      "price": 18,
    },
    {
      "name": "Waffle",
      "picture": "images/products/waff.png",
      "owner name": "Happy making",
      "category": "Food",
      "price": 18,
    },
    {
      "name": "Painted Cup",
      "picture": "images/products/hand.jpg",
      "owner name": "Happy making 2 ",
      "category": "Handmade",
      "price": 18,
    },
    {
      "name": "Painted Cup",
      "picture": "images/products/hand.jpg",
      "owner name": "Happy making 2 ",
      "category": "Handmade",
      "price": 18,
    },

    {
      "name": "Painted Cup",
      "picture": "images/products/hand.jpg",
      "owner name": "Happy making 2 ",
      "category": "Handmade",
      "price": 18,
    },


  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
     // physics:NeverScrollableScrollPhysics() ,

          itemCount: product_list.length,
         //scrollDirection: Axis.vertical,
          shrinkWrap: true,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Single_prod(
                product_name: product_list[index]['name'],
                product_picture: product_list[index]['picture'],
                product_owner: product_list[index]['owner name'],
                product_category: product_list[index]['category'],
                product_price: product_list[index]['price'],
              ),
            );
          }

    );
  }
}

class Single_prod extends StatelessWidget {
  final id;
  final product_name;
  final product_picture;
  final product_owner;
  final product_category;
  final product_price;

  Single_prod(

      {
        this.id,
        this.product_name,
      this.product_picture,
        this.product_owner,
      this.product_category,
      this.product_price});

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return  Card(


        child: Hero(
          //كان في جوا التاق (product_name)  غيرتو عشان كان في مالتبيل هيروز
          tag: Text(product_name),
          child: Material(

            child: InkWell(
                  //when onTap on specific context
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                    builder: (context) => ProductDetailsLatestProducts(
                      // the property of the constructor,
                      // we are passing the values from
                      // products to products_details
                      product_detail_name: product_name ,

                      product_detail_owner: product_owner,
                      product_detail_picture: product_picture,
                      product_detail_price: product_price,

                    ),
                ),
                ),//push

                child: GridTile(
                  footer: Container(
                    height:90,
                    color: white,
                    child: ListTile(

                      leading: Text(product_name,
                          style: TextStyle(fontWeight: FontWeight.bold,color:black)),
                      title: Text(
                        "SR $product_price",
                        style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.w300 ,),
                      ),
                      subtitle: Text(
                        "Account Name : $product_owner",
                        //ربا هنا قبل التيكست ستايل كان في const شلتها لانو اللون مارضي يتغير الا هنا
                        style: TextStyle(
                             fontWeight: FontWeight.w800, fontSize: 12,color:black,),
                      ),
                    ),
                  ),
                  child: Image.asset(product_picture, fit: BoxFit.contain,),
                )),
          ),
        ),

    );
  }
}
