import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'login.dart';

class LandingPage extends StatelessWidget {
  //optional parameter
  LandingPage({Key? key}) : super(key: key);
  Future <FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {

    // use FutureBuilder to initialize the app
    return FutureBuilder(
        future: _initialization,
        builder: (BuildContext context, AsyncSnapshot <dynamic> snapshot) {

          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error: ${snapshot.error.toString()}"),
              ),
            );
          }else if (snapshot.hasData) {
            print("firebase initializeddd");

          }

          else {
            return Center(child: Image.asset('images/logo.png',height: 100,width: 100,),);
          }

          // the connection is done for snapshot
          if(snapshot.connectionState == ConnectionState.done){
            //get live state by use firebase to tell if logged in or not
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context,snapshot){
                if (snapshot.connectionState == ConnectionState.active) {
                  //Object? user = snapshot.data;
                  return HomePage();

                }
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Image.asset('images/logo.png'),
                      CircularProgressIndicator(),
                      Text("Checking Authnetication ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,color: Colors.grey )),


                  ]
                  ),
                );

              },

            );
          }


          return Scaffold(
            backgroundColor: Colors.grey,
            body: Column(
              children:[
                CircularProgressIndicator(),
                Text("initializing the App ",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 30),textAlign: TextAlign.center,),
          ]
          ),
          );
        }

    );
  }
}
