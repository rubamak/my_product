import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/pages/home.dart';
import 'package:my_product/components/cart_products.dart';
import 'package:my_product/widgets/main_drawer.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        //elevation: 0.9,// remove the shadows
        backgroundColor: basicColor,
        title:  Text("My Cart"),


        /*actions: <Widget>[
           IconButton(
              icon: Icon(Icons.search, color: Colors.white), onPressed: () {}),
           IconButton(
              icon: Icon(Icons.translate, color: Colors.white),
              onPressed: () {}),
        ],*/
      ),

      /*
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: new Text('Total Orders'),
                subtitle: new Text(),
              ) ,

            ),
          ],
        ),
      ),*/

      /*Drawer(
        child: ListView(
          children: <Widget>[
            //header
            UserAccountsDrawerHeader(
              accountName: Text('Ruba almakkawi'),
              accountEmail: Text('rooooby_222@hotmail.com'),
              currentAccountPicture: GestureDetector(
                  child:  CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.grey),
              )),
              decoration: BoxDecoration(
                color: Color(0xffFFBCBC),
              ),
            ),

            //body
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  HomePage()));
                },
                child: ListTile(
                  title: Text('Home Page'),
                  leading: Icon(Icons.home_outlined),
                )),
            InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('My Profile'),
                  leading: Icon(Icons.person_outline_sharp),
                )),

            //no need to repeat the categories
            /*InkWell(
                onTap:(){},
                child: ListTile(
                  title: Text('Categories'),
                  leading: Icon(Icons.dashboard_outlined),
                )
            ),*/

            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  Cart()));
                },
                child: ListTile(
                  title: Text('My Orders'),
                  leading: Icon(Icons.shopping_bag_outlined),
                )
            ),
            InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('My Favourites'),
                  leading: Icon(Icons.favorite_outline),
                )),
            InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('My Chats'),
                  leading: Icon(Icons.chat_outlined),
                )),
            Divider(color: Color(0xffFFBCBC)),

            InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Settings'),
                  leading: Icon(Icons.settings),
                )),
            InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Enjoy To Help You'),
                  leading: Icon(Icons.help_outline),
                )),
          ],
        ),
      ),*/
      body: Cart_products(),
    );
  }
}
