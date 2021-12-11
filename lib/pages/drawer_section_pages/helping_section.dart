import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpingSection extends StatelessWidget {
  const HelpingSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Scaffold(
        backgroundColor: basicColor,
        body: Container(

                  height: MediaQuery.of(context).size.height - 30,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(130),
                        bottomRight: Radius.circular(130),
                      )),
            alignment: Alignment.center,
            padding: EdgeInsets.all(20.0),
            child:  Column(

                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('images/myLogo.png',height: 300,width:200 ,),
                  SizedBox(child: Text("My Product",
                    style: TextStyle(fontWeight: FontWeight.w700,fontSize: 35),),),
                  SizedBox(child: Text("it is an application "
                      "that help you to deal with productive family easily comfortably,"
                      " depend on categories that help people to find what"
                      " they need in fast and direct way"
                      ,textAlign: TextAlign.center,style:
                    TextStyle(fontStyle: FontStyle.italic,fontSize: 26),),),
                  SizedBox(child: Text(" press below to visit out website"),),

                  TextButton.icon(
                    label: Text("Contact us!",style: TextStyle(color: Colors.redAccent,
                        decoration: TextDecoration.underline),),
                    icon:Icon(Icons.outbond_outlined,color: Colors.redAccent,) ,

                    onPressed: ()async{

                            try{
                              await canLaunch("http://myproductsaou.rf.gd/?i=2")?
                              await launch("http://myproductsaou.rf.gd/?i=2"):
                              throw 'could not get the video';
                            }catch(e){
                              print(e.toString());
                              AwesomeDialog(body: Text("check your internet!"))..show();

                            }



                    },

                  ),
                ],
              ),
            )
          ),

    );
  }
}
