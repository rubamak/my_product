
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';

// the father class
class ProductDetailsLatestProducts extends StatefulWidget {
  static const routeName = '/productDetails';

  final product_detail_name;
  final product_detail_owner;

  final product_detail_price;
  final product_detail_picture;

  ProductDetailsLatestProducts({
    this.product_detail_name,
    this.product_detail_owner,
    this.product_detail_picture,
    this.product_detail_price,
  });

  @override
  _ProductDetailsLatestProductsState createState() => _ProductDetailsLatestProductsState();
}

// the sub class of ProductDetails so when i use any attribute in father class i use widgets.variable name
class _ProductDetailsLatestProductsState extends State<ProductDetailsLatestProducts> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //elevation: 0.9,// remove the shadows
        backgroundColor: basicColor,
        title: Text("",style: TextStyle(color:black),),
      ),
      //body

      body: ListView(
        children: <Widget>[
          new Container(
              height: 350,
              child: GridTile(
                child: Container(
                  color: white,
                  child: Image.asset(
                    // use widget.variable name to use any thing in father class
                    widget.product_detail_picture, fit: BoxFit.contain,
                  ),
                ),
                footer: Container(
                  color:white,
                  child: ListTile(
                    leading: new Text(widget.product_detail_name,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: black)),
                    title: new Row(children: <Widget>[
                      Expanded(
                        child: new Text(
                          "SR ${widget.product_detail_price} ",
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              color: black),
                        ),
                      ),
                      Expanded(
                        child: new Text(
                          "Owner: ${widget.product_detail_owner}",
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              color: black),
                        ),
                      ),
                    ]),
                  ),
                ),
              )
          ),

          //=================== first Button=================
          Row(
            children: <Widget>[
              //=======the Quantity button=======
              Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return new AlertDialog(
                              title: new Text('Quantity',style: TextStyle(color:black),),
                              content: new Text("Choose number of Quantity",style: TextStyle(color:black)),
                              actions: <Widget>[
                                new MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(context);
                                  },
                                  child: new Text("close",style: TextStyle(color:black)),
                                )
                              ],
                            );
                          });
                    },

                    height: 70,
                    color: white,
                    textColor: black,
                    //elevation: 0.2,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: new Text(
                            "Quantity",
                            style: TextStyle(fontSize: 30,color:black),
                          ),
                        ),
                        Expanded(
                          child: new Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            size: 30,color:black
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),

          //=======the second button=======
          Row(children: <Widget>[
            Expanded(
              child: MaterialButton(
                onPressed: () {},

                height: 70,
                color: basicColor,
                textColor: black,
                //elevation: 0.2,
                child: new Text(
                  "Order !",
                  style: TextStyle(fontSize: 30,color:black),
                ),
              ),
            ),
            new IconButton(
                onPressed: () {}, icon: Icon(Icons.add_shopping_cart,color:grey)),
            new IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border,color:grey)),
          ]),
          Divider(
            color: Colors.black87,
          ),
          new ListTile(
            title: new Text("product details",style: TextStyle(color:black)),
            subtitle: new Text("lorem Ipsum,"
                "sometimes referred to as 'lipsum',"
                " is the placeholder text used in design"
                " when creating content."
                " It helps designers plan out where"
                " the content will sit, without needing to "
                "wait for the content to be written and "
                "approved.",style: TextStyle(color:black)),
          ),
          Divider(
            color:black,
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  "The Owner : ${widget.product_detail_owner}",
                  style: TextStyle(color: grey),
                ),
              ),
              //========== add later the conditions of each product======
               Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  "The Condition to order: ",
                  style: TextStyle(color: grey),
                ),
              ),

              //createFloatingActionButton()
            ],


          ),
        ],
      ),


    );
  }

  Widget createFloatingActionButton() {
    return FloatingActionButton.extended(
      label: Text("add",style: TextStyle(color:black),),
      backgroundColor: Colors.red,
      onPressed: (){},
      icon:  Icon(Icons.favorite_border,color:grey),


    );




  }




}
