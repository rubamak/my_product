
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/pages/drawer_section_pages/single_chat_screen.dart';
import 'package:my_product/pages/products_screen.dart';

class FamilyItem extends StatelessWidget {
  final int familyId ;

  final String familyName;
  final String description;
  final String familyImage;

  FamilyItem(this.familyId, this.familyName, this.description, this.familyImage);

  void selectFamily(BuildContext context){
    Navigator.of(context).pushNamed(
      ProductsScreen.routeName,
      arguments: {
        'id': familyId,
        'name': familyName,
      }

    );

  }
  void chatWithFamily (BuildContext context, int familyId){
    Navigator.of(context).pushNamed(
      SingleChatScreen.routeName,
      arguments: {
        'id': familyId,
        'name': familyName,
      }

    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: (){
              selectFamily(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Hero(
                      tag: familyId,
                        child: Image(
                      image: AssetImage(familyImage),
                      fit: BoxFit.cover,
                      height: 75,
                      width: 75,
                    )
                    ),

                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                         Text(familyName,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                         SizedBox(height: 5,),

                      Container(
                        width: 200,
                          child:
                              Text(description,
                              softWrap: true,
                              //  overflow: TextOverflow,
                                style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: grey),)

                      )

                      ],
                    )
                ],
                ),
              ),
              IconButton(
                onPressed: ()=> chatWithFamily(context,familyId),
                 // Navigator.of(context).pushNamed(ChatScreen.routeName);


                icon: Icon(Icons.chat_outlined),
                color: black,
              )

            ],

            ),
          ),
          // child: Card(
          //   child: Container(
          //
          //     padding: EdgeInsets.all(50),
          //     margin: EdgeInsets.all(20),
          //     child: Column(
          //       children:[
          //         Text(familyName,
          //         //textAlign: TextAlign.center,
          //         style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),),
          //        Text(description, style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
          //     ])
          //     ,
          //
          //     decoration: BoxDecoration(
          //       color: Colors.lightBlue[50],
          //       borderRadius: BorderRadius.circular(50),
          //     ),
          //
          //   ),
          // )

    );
  }
}
