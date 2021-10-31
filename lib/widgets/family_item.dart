
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/pages/drawer_section_pages/single_chat_screen.dart';
import 'package:my_product/pages/products_screen.dart';
import 'dart:io';
class FamilyItem extends StatelessWidget {
  final String userId;
  final String familyStoreId ;
  final String categoryId;
  final String categoryName;
  final String familyName;
  final String description;
  final String familyImage;

  FamilyItem({
     this.familyStoreId,
     this.familyName,
     this.description,
     this.familyImage,
     this.categoryName,
     this.userId,
     this.categoryId
  });

  void selectFamily(BuildContext context){
    Navigator.of(context).pushNamed(
      ProductsScreen.routeName,
      arguments: {
        'id': familyStoreId,
        'name': familyName,
      }
    );

  }
  void chatWithFamily (BuildContext context){
    Navigator.of(context).pushNamed(
      SingleChatScreen.routeName,
      arguments: {
        'id': familyStoreId,
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
                      tag: familyStoreId,
                        child:
                            familyImage != null ? 
                        Image.network(familyImage,
                      fit: BoxFit.cover,
                      height: 75,
                      width: 75,
                        ):
                            Image.network("https://previews.123rf.com/images/thesomeday123/thesomeday1231712/thesomeday123171200009/91087331-default-avatar-profile-icon-for-male-grey-photo-placeholder-illustrations-vector.jpg",
                              fit: BoxFit.cover,
                              height: 75,
                              width: 75,
                            )                    ),

                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                         Text(familyName??"none",style: TextStyle(color:black,fontSize: 17,fontWeight: FontWeight.bold),),
                         SizedBox(height: 5,),

                      Container(
                        width: 200,
                          child:
                              Text(description??"none",
                              softWrap: true,
                               overflow: TextOverflow.fade,
                                style: TextStyle(fontSize: 17,fontWeight: FontWeight.normal,color: grey),)

                      ),
                        Text("${categoryName} Store" ??"none",style: TextStyle(color:black),),
                      ],
                    )
                ],
                ),
              ),

              IconButton(
                onPressed: ()=> chatWithFamily(context),
                 // Navigator.of(context).pushNamed(ChatScreen.routeName);
                icon: Icon(Icons.chat_outlined,color: black,),
                color: black,
              )
            ],
            ),
          ),
    );
  }
}
