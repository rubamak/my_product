import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
        builder: (context, snapshot) {

          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error: ${snapshot.error.toString()}"),
              ),
            );
          }else if (snapshot.hasData) {
            print("firebase initializeddd");


            // return "";
              // TypeOfUser();
            //Login();


          }

          else {
            return Center(
                child:
                CircularProgressIndicator()
               );
          }


          // the connection is done for snapshot
          if(snapshot.connectionState == ConnectionState.done){
            //get live state by use firebase to tell if logged in or not

            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context,snapshot){
                if (snapshot.connectionState == ConnectionState.active) {
                  Object? user = snapshot.data;

                 if(user == null){
                    // return  //HomePage();
                    // TypeOfUser();
                      //Login();

                  }else {
                    // return //HomePage();
                    //   TypeOfUser();
                  }
                }
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Container(
                        padding: EdgeInsets.all(50.0),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/myLogo.png")
                            )
                        ),
                      ),

                      Text("Checking Authnetication ",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: Colors.grey )),


                  ]
                  ),
                );

              },

            );
          }


          return Scaffold(
            backgroundColor: Colors.grey,
            body: Center(
              child: Text("initializing the App ",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 30)),
            ),
          );
        }

    );
  }
}
