import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/helper/shared_pref.dart';
import 'package:my_product/pages/Registration_page.dart';
import 'package:my_product/pages/home_page.dart';
import 'package:get/get.dart';
import 'package:my_product/pages/reset_password_page.dart';

// ===the packages the packages that added in pubspec.yaml==

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
 // const Login({Key key, }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
  bool isLoading = false;
}

class _LoginState extends State<Login> {

  void initState(){
    var userCred = FirebaseAuth.instance.currentUser;
    print(userCred);
    super.initState();

  }


      _loginUser() async {
        FocusScope.of(context).unfocus();

        if (!_formKey.currentState.validate()) {
      print("Not valid login");


    } else {
      _formKey.currentState.save();
      print(" valid login ");
      // print
   //   SharedPref.saveUserEmailShared(_email);

      try {

        setState(() {
          widget.isLoading = true ;
        });


        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.trim(), // عشان يشيل الفراغات
          password: _password.trim(),// عشان يشيل الفراغات
              );
            //.then((value) {

          //SharedPref.saveUserLoggedInShared(true);
         // Get.off(()=> HomePage());

        //});
        // تعجيييييللل هنا تعديل return userCredential;
        return userCredential;

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          AwesomeDialog(
              context: context,
              title: "Error",
              showCloseIcon: true,
              body: Text("user not registered, not found !",style: TextStyle(color: black),))
            ..show();

          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          AwesomeDialog(
              context: context,
              title: "Error",
              showCloseIcon: true,
              body: Text("wrong password",style: TextStyle(color: black),))..show();
        }
        setState(() {
          widget.isLoading = false ;
        });
      }

    }

  }


  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPass = TextEditingController();
  bool passwordVisible = true;
  var _email;
  var _password;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: new AppBar(
        iconTheme: IconThemeData(color: black),
        leading:  IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
           Get.back();
          },
          color: black,
        ),
        elevation: 0,// remove the shadows
        backgroundColor: basicColor,
        //كان هنا في كونست وشلتها ياربا عطلتني عن شغله :قبل التكست
        title: Text(
          "Login page ",
          style: TextStyle(fontSize: 30,color: black ),
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
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(100),
                       // bottomRight:Radius.circular(150),
                      )),

                       child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 80,horizontal: 20),
                        child: ListView(
                          children: [
                            SizedBox(height: 40,),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2,color:basicColor),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: "Enter Email :",
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w400, fontStyle: FontStyle.italic,color:black),
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
                              borderSide: BorderSide(width: 2,color:basicColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText: "Enter password :",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w400, fontStyle: FontStyle.italic,color: black),
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
                        InkWell(
                          onTap: (){
                            Get.off(()=> ResetPasswordPage());

                          },
                          child: Container(alignment: Alignment.centerRight,
                            child: Container(

                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                              child: Text("forget password ?",style: TextStyle(
                                decoration: TextDecoration.underline,
                                  color: basicColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),)),),
                        ),
                        if(widget.isLoading)
                          Center(child: CircularProgressIndicator(),),
                        if(!widget.isLoading)
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: MaterialButton(
                            color: basicColor,
                            child: Text(
                              " login ",
                              style: TextStyle(color: black),
                            ),
                            onPressed: () async {
                              var  userCred = await _loginUser();
                              if(userCred != null){
                                //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomePage()));
                                Get.off(()=> HomePage());
                                SharedPref.saveSharedPreferences(_email);
                                Fluttertoast.showToast(msg: 'you signed in ');
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 20,),
                        if(!widget.isLoading)
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row( mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't Have an account.",
                                  style: TextStyle(color: black),
                                ),
                                MaterialButton(
                                  // color: basicColor.withOpacity(0.2),
                                  child: Text(
                                    " Create new Account ",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: basicColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  onPressed: () {

                                    Get.off(()=> Registartion());
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
