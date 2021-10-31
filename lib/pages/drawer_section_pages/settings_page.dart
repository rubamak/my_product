

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/pages/home_page.dart';
import 'package:my_product/widgets/main_drawer.dart';
import 'package:get/get.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: black,),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: white,
        ),

        title: Padding(
          padding: EdgeInsets.only(top: 1),
          child: Text("settings",
            style: TextStyle(
              color: black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),),
        ),
        backgroundColor: basicColor,
        toolbarHeight: 80,
      ),
      backgroundColor: basicColor,
      //endDrawer: MainDrawer(),

      body: ListView(
          children: <Widget>[
            SizedBox(height: 20,), //between them
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height - 180,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    bottomRight: Radius.circular(150),
                  )
              ),
              child: ListView(
                primary: false,
                padding: EdgeInsets.only(left: 25, right: 25),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 45),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 300,

                      child: ListTile(
                        leading: Image.asset('images/categories/darkMode.png',
                          alignment: Alignment.topLeft,),
                        subtitle: Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                              print(isSwitched);

                              if (isSwitched == true) {
                                black = Colors.white;
                                white = Colors.black;
                              }
                              if (isSwitched == false) {
                                black = Colors.black;
                                white = Colors.white;
                              }
                            });
                          },
                          activeColor: Colors.white,
                          inactiveThumbColor: Colors.grey[700],
                          inactiveTrackColor: Colors.grey,

                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ]
      ),
    );
  }
}