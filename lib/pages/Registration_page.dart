
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
  static var accountType = {"Choose one","user", "Productive Family"};

  bool passwordVisible = true;
  bool passwordVisible2 = true;

  var  _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _firstNameController = TextEditingController();
  var _lastNameController = TextEditingController();
  var _usernameController = TextEditingController();

  var myEmail ,firstName, lastName, username, myPassword;
  var _isLoading = false;


  /*void _switchAuthMode(){
     if(_authMode== AuthMode.Login){
       setState(() {
         _authMode == AuthMode.SignUp;
       });
     }else{
       setState((){_authMode == AuthMode.Login;});
     }
   }*/


  static String? valueChoose;
  static List  listItems = ["User","productive Family"];
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Colors.grey[200],
      body:Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ListView(
              children: [
                Container(child: Text("Sign up Form ",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,backgroundColor: Colors.grey[200]),),),
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
                      labelStyle: TextStyle(color: Colors.black54),
                      //hintText: "Ruba..",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontStyle: FontStyle.italic),
                      prefixIcon: IconButton( icon: Icon(Icons.person_pin_outlined, color: Colors.black54,), onPressed: () {  },),
                    ),
                    keyboardType: TextInputType.name,
                    cursorColor: white,
                    controller: _firstNameController,
                    validator: (val){
                      if(val!.isEmpty|| val.length < 2) {
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

                    //type of text
                    //keyboardType: TextInputType.,
                    style: TextStyle(color: Colors.black54),
                    decoration: InputDecoration(labelText: "Enter Your Last Name:",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: basicColor),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelStyle: TextStyle(color: Colors.black54),
                      //hintText: "Almakkawi",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black54,
                          fontStyle: FontStyle.italic),
                      prefixIcon: IconButton( icon: Icon(Icons.people_alt_outlined, color: Colors.black54,), onPressed: () {  },),
                    ),
                    keyboardType: TextInputType.name,
                    cursorColor: white,
                    controller:   _lastNameController,
                    validator: (val){
                      if(val!.isEmpty ) {
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
                    style: TextStyle(color: Colors.black54),
                    decoration: InputDecoration(labelText: "Enter username :",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: basicColor),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelStyle: TextStyle(color: Colors.black54),
                      hintText: "roro store/ roro_99",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black54,
                          fontStyle: FontStyle.italic),
                      prefixIcon: IconButton( icon: Icon(Icons.people_alt_outlined, color: Colors.black54,), onPressed: () {  },),
                    ),
                    keyboardType: TextInputType.name,
                    cursorColor: white,
                    controller:   _usernameController,
                    validator: (val){
                      if(val!.isEmpty ) {
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
                    style: TextStyle(color: Colors.black54),
                    decoration: InputDecoration(labelText: "Enter Email:",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: basicColor),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelStyle: TextStyle(color: Colors.black54),
                      hintText: "example@gmail.com",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black54,
                          fontStyle: FontStyle.italic),
                      suffixIcon: IconButton(onPressed: _emailController.clear, icon: Icon(Icons.cancel, color: Colors.black54,),),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: white,
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
                    style: TextStyle(color: Colors.black54),
                    decoration: InputDecoration(labelText: "Enter Password:", labelStyle: TextStyle(color: Colors.black54),
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
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    obscureText: passwordVisible,
                    keyboardType: TextInputType.visiblePassword,
                    cursorColor: white,
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
                    style: TextStyle(color: Colors.black54),
                    decoration: InputDecoration(labelText: "Confirm Password", labelStyle: TextStyle(color: Colors.black54),
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
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    obscureText: passwordVisible2,
                    keyboardType: TextInputType.visiblePassword,
                    cursorColor: white,
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
                    child: Text('Sign Up'),
                    onPressed: signUp,
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
                  child: ElevatedButton(
                    child: Text('Return to Login '),
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Login()))
                    ,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25), ),),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),




    );
  }

  //FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("Users");



  Future<void> signUp() async {
    // var formData = _formKey.currentState;
    // if(formData!.validate()){
    //هدول السطرين يكافؤ السطر الي تحت في سطر واحد
    // }
    //يتاكد من الاشياء الي داخل الفورم يتحقق منها عشان بعدها يخزنها
    if(!_formKey.currentState!.validate()){
      //return ;
      print("not valid");
    }else
      print("vaild");
    // حفظ الداتا الي تحقق منها داخل الفورم
    _formKey.currentState!.save();
    _createUser();
    //انشاء حساب لليوزر جديد


    //
    //Navigator.pushReplacementNamed(context, HomePage.routeName);
    // addUser();
    // Fluttertoast.showToast(msg: "Account has Successfully created ");


  }
  //add user to collection on firebase
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  Future addUser() async{
    return users.add({
      "email":_emailController.text,
      'name': _firstNameController.text,
      'last name': _lastNameController.text,
      'username': _usernameController.text,
      'password': _passwordController.text,
    }).then((value) =>
        print("user added!"));
  }

  // Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth = await googleUser
  //       ?.authentication;
  //
  //
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //   //addUser();
  //   //Fluttertoast.showToast(msg: "google account created!");
  //
  //
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  //
  // }
  User? user = FirebaseAuth.instance.currentUser;
  Future<void> _createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: myEmail, password: myPassword);
      print(userCredential.user!.email);
      print("===================================");
      //print(userCredential.user!.displayName);
      //print(userCredential.user!.uid);
      Fluttertoast.showToast(msg: "Account has Successfully created ");
      addUser();

      // if( userCredential.user!.emailVerified ==false ) {
      //   await user!.sendEmailVerification();
      // }

    } on FirebaseException catch(e){
      if( e.code == 'weak-password') {
        AwesomeDialog(context: context, title: "Something wrong!",
          body: Text("password is too weak"), )..show();
        print("weak pass");
      }else if (e.code == 'email-already-in-use'){
        AwesomeDialog(context: context, title: "Something wrong!",
          body: Text("email is used by another account.."), )..show();
        print("emaid is used ");
        // showDialog(context: context, builder: (BuildContext context){
        //     return AlertDialog(
        //       title: Text("Something Wrong !"),
        //       content:
        //       Text(e.toString() ),
        //       actions: [
        //         TextButton(
        //           child: Text("ok"),
        //           onPressed: (){
        //             Navigator.of(context).pop();
        //           },
        //         )
        //       ],
        //
        //
        //     );
        //   });

      }
      // showDialog(context: context, builder: (BuildContext context){
      //   return AlertDialog(
      //     title: Text("Error"),
      //     content:
      //     Text(e.toString() ),
      //     actions: [
      //       TextButton(
      //         child: Text("ok"),
      //         onPressed: (){
      //           Navigator.of(context).pop();
      //         },
      //       )
      //     ],
      //
      //
      //   );
      // });

    }

    catch(err){
      Center(child: CircularProgressIndicator());
      print(err);
    }


    // Navigator.pushNamed(context, '/');  زبط ولكن ما يعرض لي بيانات المستخدم

  }

//   static List categoryList =
//   [ "Food","Drinks","Clothes","Homemade","Digital Services" ];
// static String? categoryChoose;
//
//  Widget familyType() {
//
//   return Container(
//     child: valueChoose == listItems[0]? null  :
//     Container(
//       padding: EdgeInsets.all(10),
//       margin: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: white,width: 2)
//       ),
//       child: Column(
//         children: [
//           DropdownButton(
//
//             borderRadius: BorderRadius.circular(20),
//             hint: Text("select your Category:"),
//             isExpanded: true,
//             value: categoryChoose,
//             onChanged: (newValue){
//               setState(() {
//                 categoryChoose = newValue as String?;
//
//               });
//             },
//             items: categoryList.map((catItem) {
//               return DropdownMenuItem(
//
//                 value: catItem,
//                 child: Text(catItem),
//                 enabled: true,
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     ),
//   );
//  }

}
