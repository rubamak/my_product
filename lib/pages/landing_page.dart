import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';

import 'home_page.dart';
import 'login.dart';

class LandingPage extends StatelessWidget {
  //optional parameter
  LandingPage({Key key}) : super(key: key);

  Future<FirebaseApp> _initialization = Firebase.initializeApp();


  @override
  Widget build(BuildContext context) {
    // use FutureBuilder to initialize the app
    return FutureBuilder(
        future: _initialization,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error.toString()}"));
          } else if (snapshot.hasData) {
            print("=========firebase initialized===========");
          } else {
            return Center(
              child:
              Image.asset(
                'images/logo.png',
                height: 100,
                width: 100,
              ),
            );
          }

          // the connection is done for snapshot
          if (snapshot.connectionState == ConnectionState.done) {
            //get live state by use firebase to tell if logged in or not
            return

            StreamBuilder(
              stream: Stream.periodic(Duration(seconds: 2)),
              //FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  //Object? user = snapshot.data;
                  return HomePage();
                }
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('images/myLogo.png',height: 200,width:600 ,),
                          //SizedBox(height: 20,),
                          Text("Welcome",
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 35,
                                  color: basicColor)),
                          CircularProgressIndicator(),
                        ]),
                  ),
                );
              },
            );
          }
          return Scaffold(
            backgroundColor: Colors.grey,
            body: Column(children: [
             const CircularProgressIndicator(),
              Center(
                  child: Text(
                "initializing the App ",
                style: TextStyle(color: black,fontWeight: FontWeight.w600, fontSize: 30),
                textAlign: TextAlign.center,
              )),
            ]),
          );
        });
  }
}
