import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/pages/Registration_page.dart';
import 'package:my_product/pages/home.dart';

// ===the packages the packages that added in pubspec.yaml==

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


  // function every time called will create a new account and insert in firebase
  // Future<void> _createUser() async {
  //   try {
  //     // print("email: $_email, pass: $_password");
  //     // to create account and added to firebase
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: _email, password: _password);
  //     print("yeeeeeeeeeeessssssssssssss");
  //   } catch (e) {
  //     print("Error : $e");
  //   }
  // }

  Future<void> _loginUser() async {
    try {
      // print("Emmmmmmmail: $_email, نننننتنتpassword: $_password");
      // to create account and added to firebase
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      //to showing the details of data in firebase within console
     // Navigator.of(context).pushNamed('/');
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HomePage()));

      print("Loggginnnnn dooooooooooonnnnnnnnnneeeeeeeeee");
    } catch (e) {
      print("Error : $e");
    }

  }

/*
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late SharedPreferences preferences ;

   bool loading = false;
   bool isLogedin = false;


  //final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // sharedPreferences is show if you login for first time the app
  //will show press here and this and that(tutorial screen)
  // but if the second login it will not show you these instructions.


  @override
  void initState() {
    //called initState for Login base class
    super.initState();
    // is SignedIn() I create this method
    isSignedIn();
  }
  //async (wait something that is going from future) word is while load the state it can doing something else
  void isSignedIn() async {
    // start loading
    setState(() {
      loading = true;
    });

    // await is to hold for bit to get the data in the future
    preferences = await SharedPreferences.getInstance();
    isLogedin = await googleSignIn.isSignedIn();

    // or if(isLogedin)
    if (isLogedin == true) {
      //pushReplacement is for user to
      // be not able to back to login page after he login
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }

    //end loading because the user is  finish logged in
    setState(() {
      loading = false;
    });
  }


  // method of type future that waiting something
  //handleSignIn to handle the sign in
  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true; });

   GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleUser!.authentication;
    FirebaseUser firebaseUser = await firebaseAuth.signInWithGoogle(
        idToken: googleSignInAuthentication.idToken,
    accessToken: googleSignInAuthentication.accessToken);

    if(firebaseUser != null){
      final QuerySnapshot result = await FirebaseFirestore.instance.collection("user").
      where("id",isEqualTo: firebaseUser.uid).get();

      final List<DocumentSnapshot> documents = result.docs;


    }else{

    }

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,);

    return await FirebaseAuth.instance.signInWithCredential(credential);

  }
*/
  var _controllerEmail = TextEditingController();
  var _controllerPass = TextEditingController();
  bool passwordVisible = true;
  late String _email;
  late String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        //elevation: 0.9,// remove the shadows
        backgroundColor:basicColor,
        title: const Text('Login page ',style: TextStyle(fontSize: 30),),
        toolbarHeight: 100,

      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: NetworkImage(
        //         "https://img.etimg.com/thumb/msid-66290834,width-300,imgsize-69978,,resizemode-4,quality-100/mobile-apps-getty.jpg"),
        //     fit: BoxFit.cover,
        //     colorFilter: ColorFilter.mode(Colors.black87, BlendMode.darken),
        //   ),
        // ),
        child: ListView(
            children: <Widget>[
          SizedBox(
            height: 200,
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),),
              labelText: "Enter Email :",
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
              prefix:  Icon(Icons.email_outlined,),
              suffixIcon: IconButton(
                onPressed: _controllerEmail.clear,
                icon: Icon(Icons.cancel,color: black,),),
            ),
            onFieldSubmitted: (dynamic value){
              //عند ضغط الانتر
              print("email entered is: "+ value);
            },
            onChanged: (dynamic value) {
              //عند التغيير في القيمة الي في النص يعمل شي
              _email = value;
             // print(value);
            },
            // onTap: ,
            // onSaved: ,
            controller: _controllerEmail,
          ),
              SizedBox(
                height: 20,
              ),

              TextFormField(
                obscureText: passwordVisible,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),),
                  labelText: "Enter password :",
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                  prefix:  Icon(Icons.lock_outline,),

                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    icon: Icon(passwordVisible? Icons.visibility_off: Icons.visibility,color:black,),),
                ),
                onFieldSubmitted: (dynamic value){
                  //عند ضغط الانتر

                },
                onChanged: (dynamic value) {
                  //عند التغيير في القيمة الي في النص يعمل شي
                  _password = value;
                },
                controller: _controllerPass,

              ),
            SizedBox(height: 50,),


                    MaterialButton(
                          color: basicColor,
                          child: Text(
                            " login ",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed:() => _loginUser(),
                        ),
                    SizedBox(height: 20,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't Have an account.",),
                          MaterialButton(
                            // color: basicColor.withOpacity(0.2),
                            child: Text(
                              " Create new Account ",
                              style: TextStyle(color: basicColor,fontWeight: FontWeight.bold,fontSize: 18),
                            ),
                            onPressed:() {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>  Registartion()));

                            },
                          ),
                        ],
                      ),
                    ),

                  ],
                ),

            ),
    );
  }
}
