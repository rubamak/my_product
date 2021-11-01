
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/widgets/category_item.dart';
import 'package:select_form_field/select_form_field.dart';

import 'login.dart';
class Registartion extends StatefulWidget {


  @override
  _RegistartionState createState() => _RegistartionState();
}


class _RegistartionState extends State<Registartion> {
  bool passwordVisible = true;
  bool passwordVisible2 = true;
  var  _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _firstNameController = TextEditingController();
  var _lastNameController = TextEditingController();
  var _usernameController = TextEditingController();

  var myEmail ,firstName, lastName, username, myPassword;


  static String valueChoose;
  static List  listItems = ["User","productive Family"];
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: white,
      body:Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ListView(
              children: [
                Container(child: Text("Sign up Form ",textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,
                    backgroundColor: white,color:black),),),
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    //type of text
                    //keyboardType: TextInputType.,
                    style: TextStyle(color: Colors.black54),
                    decoration: InputDecoration(labelText: "Enter Your First Name:",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: basicColor),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelStyle: TextStyle(color: black),
                      //hintText: "Ruba..",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: white,
                          fontStyle: FontStyle.italic),
                      prefixIcon: IconButton( icon: Icon(Icons.person_pin_outlined, color:black,), onPressed: () {  },),
                    ),
                    keyboardType: TextInputType.name,
                    cursorColor: black,
                    controller: _firstNameController,
                    validator: (val){
                      if(val.isEmpty|| val.length < 2) {
                        return " Short name :(";
                      }   else{
                        return null;} ;

                    },
                    onSaved: (value){
                      firstName = value;
                    },


                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    style: TextStyle(color:black),
                    decoration: InputDecoration(labelText: "Enter Your Last Name:",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: basicColor),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelStyle: TextStyle(color: black),
                      //hintText: "Almakkawi",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: black,
                          fontStyle: FontStyle.italic),
                      prefixIcon: IconButton( icon: Icon(Icons.people_alt_outlined, color: black,), onPressed: () {  },),
                    ),
                    keyboardType: TextInputType.name,
                    cursorColor: black,
                    controller:   _lastNameController,
                    validator: (val){
                      if(val.isEmpty ) {
                        return " invalid Entry:(";
                      }else if(val.length < 2){
                        return "short last name ";
                      }
                      else{return null;} ;
                    },
                    onSaved: (value){
                      lastName = value;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(

                    //type of text
                    //keyboardType: TextInputType.,
                    style: TextStyle(color: black),
                    decoration: InputDecoration(labelText: "Enter username :",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: basicColor),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelStyle: TextStyle(color: black),
                      hintText: "roro store/ roro_99",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: black,
                          fontStyle: FontStyle.italic),
                      prefixIcon: IconButton( icon: Icon(Icons.people_alt_outlined, color: black,), onPressed: () {  },),
                    ),
                    keyboardType: TextInputType.name,
                    cursorColor: black,
                    controller:   _usernameController,
                    validator: (val){
                      if(val.isEmpty ) {
                        return " invalid Entry:(";
                      }else if (val.length<4){
                        return"short username";

                      }
                      else if( !val.contains("_")){
                        return " add any symbols";
                      }
                      else if (!val.contains(RegExp(r'[0-9]'))) {
                        return " you should add numbers ";}

                      else{
                        return null;} ;
                    },
                    onSaved: (value){
                      username = value;
                    },
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    style: TextStyle(color: black),
                    decoration: InputDecoration(labelText: "Enter Email:",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: basicColor),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelStyle: TextStyle(color: black),
                      hintText: "example@gmail.com",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: black,
                          fontStyle: FontStyle.italic),
                      suffixIcon: IconButton(onPressed: _emailController.clear, icon: Icon(Icons.cancel, color: black,),),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: black,
                    controller: _emailController,
                    validator: (val) {
                      if(val== null || !val.contains("@")|| !val.contains(".")) {
                        return " invalid Email :(";
                      }   else{return null;} ;
                    },
                    onSaved: (value){
                      myEmail = value;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    style: TextStyle(color: black),
                    decoration: InputDecoration(labelText: "Enter Password:", labelStyle: TextStyle(color: black),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color:basicColor),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() { passwordVisible = !passwordVisible;});
                        },
                        icon: Icon(
                          passwordVisible ? Icons.visibility_off : Icons
                              .visibility,
                          color: black,
                        ),
                      ),
                    ),
                    obscureText: passwordVisible,
                    keyboardType: TextInputType.visiblePassword,
                    cursorColor: black,
                    controller: _passwordController,
                    validator: (val) {
                      if(val.toString().length < 8 || val == null) {
                        return " Too Short password:(";
                      }   else{return null;} ;
                    },
                    onSaved: (value){
                      myPassword = value;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    style: TextStyle(color: black),
                    decoration: InputDecoration(labelText: "Confirm Password", labelStyle: TextStyle(color: black),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: basicColor),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() { passwordVisible2 = !passwordVisible2;});
                        },
                        icon: Icon(
                          passwordVisible2 ? Icons.visibility_off : Icons
                              .visibility,
                          color: black,
                        ),
                      ),
                    ),
                    obscureText: passwordVisible2,
                    keyboardType: TextInputType.visiblePassword,
                    cursorColor: basicColor,
                    //controller: _passwordController2,
                    validator: (val) {
                      if(val != _passwordController.text) {
                        return " passwords did not match :(";
                      }   else{return null;} ;
                    },
                  ),
                ),
                // Container(

                //familyType(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    child: Text('Sign Up',style: TextStyle(color:black),),
                    onPressed:
                      signUp,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25), ),),
                  ),
                ),
                SizedBox(width: 50,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MaterialButton(
                    child: Text('Sign with google',style:TextStyle(color:black)),
                    onPressed: signInWithGoogle,
                    // style: ElevatedButton.styleFrom(
                    //   padding: EdgeInsets.all(10),
                    //   primary: Theme.of(context).primaryColor,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(25), ),),
                  ),
                ),
                SizedBox(height: 10,),
                // Padding(
                //   padding: const EdgeInsets.all(20.0),
                //   child: ElevatedButton(
                //     child: Text('Return to Login '),
                //     onPressed: () =>
                //         Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Login()))
                //     ,
                //     style: ElevatedButton.styleFrom(
                //       padding: EdgeInsets.all(10),
                //       primary: Theme.of(context).primaryColor,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(25), ),),
                //   ),
                // ),

              ],
            ),
          ),
        ),
      ),




    );
  }

  //FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("Users");


  // var firebaseUser = FirebaseAuth.instance.currentUser;

  Future <void> signUp() async {
    // var formData = _formKey.currentState;
    // if(formData!.validate()){
    //هدول السطرين يكافؤ السطر الي تحت في سطر واحد
    // }
    //يتاكد من الاشياء الي داخل الفورم يتحقق منها عشان بعدها يخزنها
    if(!_formKey.currentState.validate()){
      //return ;
      print("not valid");
    }else
      print("vaild");
    // حفظ الداتا الي تحقق منها داخل الفورم
    _formKey.currentState.save();
    _createUser();
    //انشاء حساب لليوزر جديد
  }
  Future<void> _createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: myEmail, password: myPassword);
      print(userCredential.user.email);
      print("===================================");
      //print(userCredential.user!.displayName);
      //print(userCredential.user!.uid);
      Fluttertoast.showToast(msg: "Account has Successfully created ");
      addUser();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Login()));


      // if( userCredential.user!.emailVerified ==false ) {
      //   await user!.sendEmailVerification();
      // }

    } on FirebaseException catch(e) {
      if (e.code == 'weak-password') {
        AwesomeDialog(context: context, title: "Something wrong!",
          body: Text("password is too weak",style: TextStyle(color:black),),)
          ..show();
        print("weak pass");
      } else if (e.code == 'email-already-in-use') {
        AwesomeDialog(context: context, title: "Something wrong!",
          body: Text("email is used by another account..",style: TextStyle(color:black)),)
          ..show();
        print("emaid is used ");
      }
    } catch(err){
      Center(child: CircularProgressIndicator());
      print(err);
    }
  }
  //add user to collection on firebase
  Future addUser() async {
    CollectionReference usersRef =  FirebaseFirestore.instance.collection('users');
    User firebaseUser = await FirebaseAuth.instance.currentUser;

    //اضيف مع تحديد الاي دي لكل دوكيمنت
    //خليت الاي دي هنا نفس الاي دي لليوزر الي عمل authentication

    usersRef.doc(firebaseUser.uid).set({
      //وضفت الاي دي  في حقل كمان
      'uid': firebaseUser.uid,
      'first name': _firstNameController.text,
      'last name': _lastNameController.text,
        "email":_emailController.text,
         'username': _usernameController.text,
         'password': _passwordController.text,

    })
    //اضيف بدون ما احدد الاي دي الخاص بكل دوكيمنت
    // return usersRef.add({
    //   'first name': _firstNameController.text,
    //   'last name': _lastNameController.text,
    //   "email":_emailController.text,
    //   'username': _usernameController.text,
    //   'password': _passwordController.text,
    .then((value) {  print("user added!");});

  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;


    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth?.idToken,
    );
    addUser();
    Fluttertoast.showToast(msg: "google account created!",textColor: black);


    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);

  }





}
