

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:my_product/pages/drawer_section_pages/single_chat_screen.dart';

class Cart_products extends StatefulWidget {
  const Cart_products({Key key}) : super(key: key);

  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {

 var Products_on_the_cart = [
 {
 "name": "Fatah",
 "picture": "images/products/f.png",
 "owner name": "Happy making",
 "category": "Food",
 "price": 20,
 "quantity": 1,
 },
 {
 "name": "Painted Cup",
 "picture": "images/products/hand.jpg",
 "owner name": "Happy making 2 ",
 "category": "Handmade",
 "price": 18,
 "quantity": 2,
  },
 ];
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: Products_on_the_cart.length,
      itemBuilder: (context, index){
        return Single_cart_products(
          cart_product_name: Products_on_the_cart[index]["name"],
          cart_product_category: Products_on_the_cart[index]["category"],
          cart_product_owner: Products_on_the_cart[index]["owner name"],
          cart_product_picture: Products_on_the_cart[index]["picture"],
          cart_product_price: Products_on_the_cart[index]["price"],
          cart_product_quantity: Products_on_the_cart[index]["quantity"],
        );
      }

    );
  }
}
class Single_cart_products extends StatelessWidget {
   final  cart_product_name;
   final cart_product_picture;
   final cart_product_owner;
   final cart_product_category;
   final cart_product_price;
   final  cart_product_quantity;

  Single_cart_products({
    this.cart_product_name,
    this.cart_product_picture,
    this.cart_product_owner,
    this.cart_product_category,
    this.cart_product_price,
    this.cart_product_quantity,
});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        //leading section for an image
        leading: new Image.asset(
          cart_product_picture,width: 30, height: 50,),

        // title section
        title: new Text(cart_product_name,style: TextStyle(fontWeight: FontWeight.w600),),
        // subtitle section
        subtitle: new Column(
          children: <Widget>[
            //row inside column
            new Row(
              children: <Widget>[

                //this is for quantity of product
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: new Text('Quantity: '),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: new Text('$cart_product_quantity'),
                ),

                // ===this is for owner of the product===
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 8,8),
                  child: new Text('Owner:'),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: new Text(cart_product_owner),
                ),
                new IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SingleChatScreen()));
                  },
                  icon: Icon(Icons.chat_outlined),),

              ],
            ),


          ],
        ),
      ),
    );
  }
}


