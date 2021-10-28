import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/pages/Registration_page.dart';
import 'package:my_product/pages/home_page.dart';
import 'package:get/get.dart';

// ===the packages the packages that added in pubspec.yaml==

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

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
  saveSharedPreferences()async{
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    sharedpref.setString('email',_email);
    // sharedpref.setString(,);
    print(" shared saved");


  }
      _loginUser() async {
    if (!_formKey.currentState.validate()) {
      print("Not valid login");

    } else {
      _formKey.currentState.save();
      print(" valid login ");
      // print
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        // تعجيييييللل هنا تعديل return userCredential;
          return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          AwesomeDialog(
              context: context,
              title: "Error",
              showCloseIcon: true,
              body: Text("user not registered !"))
            ..show();

          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          AwesomeDialog(
              context: context,
              title: "Error",
              showCloseIcon: true,
              body: Text("wrong password"))..show();
        }
      }
      // }catch(e){
      //   AwesomeDialog(context: context,body:Text("some thing wrong else "))..show();
      // }
      // UserCredential userCredential = await FirebaseAuth.instance
      //     .signInWithEmailAndPassword(email: _email, password: _password);
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context) => HomePage()));
      // print("Loggginnnnn dooooooooooonnnnnnnnnneeeeeeeeee");
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
  var _email;
  var _password;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading:  IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
        ),
        elevation: 0,// remove the shadows
        backgroundColor: basicColor,
        title: const Text(
          'Login page ',
          style: TextStyle(fontSize: 30),
        ),
        toolbarHeight: 100,
      ),
      body:Form(
        key:_formKey,
        child: Container(
          color: basicColor,
          child: ListView(
              children: <Widget>[
                SizedBox(height: 20,), //between them
                Container(
                  height: MediaQuery.of(context).size.height - 180,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(100),bottomRight:Radius.circular(150),)),

                       child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 80,horizontal: 20),
                        child: ListView(
                          children: [
                            SizedBox(height: 40,),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: "Enter Email :",
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                                prefix: Icon(
                                  Icons.email_outlined,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: _controllerEmail.clear,
                                  icon: Icon(
                                    Icons.cancel,
                                    color: black,
                                  ),
                                ),
                              ),
                              onFieldSubmitted: (dynamic value) {
                                //عند ضغط الانتر
                                print("email entered is: " + value);
                              },
                              onSaved: (dynamic value) {
                                //عند التغيير في القيمة الي في النص يعمل شي
                                _email = value;
                                // print(value);
                              },
                              validator: (val) {
                                if (val == null ||
                                    !val.contains("@") ||
                                    !val.contains(".") ||
                                    val.length > 30) {
                                  return " invalid Email :(";
                                } else {
                                  print("valid email");
                                  return null;
                                }
                                ;
                              },
                              //onChanged
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
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText: "Enter password :",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                            prefix: Icon(
                              Icons.lock_outline,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                              icon: Icon(
                                passwordVisible ? Icons.visibility_off : Icons.visibility,
                                color: black,
                              ),
                            ),
                          ),
                          onFieldSubmitted: (dynamic value) {
                            print(value);
                            //عند ضغط الانتر
                          },
                          onSaved: (dynamic value) {
                            //عند التغيير في القيمة الي في النص يعمل شي
                            _password = value;
                          },
                          controller: _controllerPass,
                          validator: (val) {
                            if (val.toString().length < 8) {
                              return " Too Short password:(";
                            } else if (val.toString().length > 20) {
                              return "very long password";
                            } else {
                              return null;
                                   }
                              },
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: MaterialButton(
                            color: basicColor,
                            child: Text(
                              " login ",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              var  userCred = await _loginUser();
                              if(userCred != null){
                                //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomePage()));
                                Get.off(()=> HomePage());
                                saveSharedPreferences();
                                Fluttertoast.showToast(msg: 'you signed in ');
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row( mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't Have an account.",
                                ),
                                MaterialButton(
                                  // color: basicColor.withOpacity(0.2),
                                  child: Text(
                                    " Create new Account ",
                                    style: TextStyle(
                                        color: basicColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Registartion()));
                                  },
                                ),
                            ],
                          ),
                      ),
                        ),
                    ]),
                    ),
                )
                ]
          ),
        ),
      ),
    );
  }
}
