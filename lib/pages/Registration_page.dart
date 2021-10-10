
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/pages/home.dart';
import 'package:select_form_field/select_form_field.dart';

import 'login.dart';
 class Registartion extends StatefulWidget {


   @override
   _RegistartionState createState() => _RegistartionState();
 }

enum AuthMode {SignUp, Login }

 class _RegistartionState extends State<Registartion> {
   static var accountType = {"Choose one","user", "Productive Family"};

   bool passwordVisible = true;
   bool passwordVisible2 = true;

   var  _emailController = TextEditingController();
   var _passwordController = TextEditingController();
   var _firstNameController = TextEditingController();
   var _lastNameController = TextEditingController();
   var _usernameController = TextEditingController();


   final GlobalKey<FormState> _formKey = GlobalKey();

   //AuthMode _authMode = AuthMode.Login;

   Map <String,String> _authData = {

     'email': '',
     'firstName': '',
     'lastName': '',
     'username': '',
     'password': '',
   };
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
   @override
   Widget build(BuildContext context) {


    List  listItems = ["User","productiveFamily"];


     return  Scaffold(
       backgroundColor: grey,
       body:Center(
         child: Form(
            key: _formKey,
           child: Padding(
             padding: const EdgeInsets.only(top: 50),
             child: ListView(
                 children: [
                   Container(child: Text("Sign up Form ",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,backgroundColor: white),),),
                   Container(
                     padding: EdgeInsets.all(20),
                     child: TextFormField(


                       //type of text
                       //keyboardType: TextInputType.,
                       style: TextStyle(color: white),
                       decoration: InputDecoration(labelText: "Enter Your First Name:",
                         enabledBorder: OutlineInputBorder(
                           borderSide: BorderSide(width: 2, color: Colors.white),
                           borderRadius: BorderRadius.circular(20.0),
                         ),
                         labelStyle: TextStyle(color: white),
                         hintText: "Ruba..",
                         hintStyle: TextStyle(
                             fontWeight: FontWeight.w900,
                             color: Colors.white,
                             fontStyle: FontStyle.italic),
                         prefixIcon: IconButton( icon: Icon(Icons.person_pin_outlined, color: Colors.white,), onPressed: () {  },),
                       ),
                       keyboardType: TextInputType.name,
                       cursorColor: white,
                       controller: _firstNameController,
                       validator: (val){
                          if(val== null) {
                             return " invalid Entry(";
                               }   else{return null;} ;

                              },
                         onSaved: (value){
                         _authData['firstName']= value!;
                         print(_authData['firstName']);
                         },


                     ),
                   ),
                   Container(
                     padding: EdgeInsets.all(20),
                     child: TextFormField(

                       //type of text
                       //keyboardType: TextInputType.,
                       style: TextStyle(color: white),
                       decoration: InputDecoration(labelText: "Enter Your Last Name:",
                         enabledBorder: OutlineInputBorder(
                           borderSide: BorderSide(width: 2, color: Colors.white),
                           borderRadius: BorderRadius.circular(20.0),
                         ),
                         labelStyle: TextStyle(color: white),
                         hintText: "Almakkawi",
                         hintStyle: TextStyle(
                             fontWeight: FontWeight.w900,
                             color: Colors.white,
                             fontStyle: FontStyle.italic),
                         prefixIcon: IconButton( icon: Icon(Icons.people_alt_outlined, color: Colors.white,), onPressed: () {  },),
                       ),
                       keyboardType: TextInputType.name,
                       cursorColor: white,
                       controller:   _lastNameController,
                       validator: (val){
                         if(val== null) {
                           return " invalid Entry:(";
                         }   else{return null;} ;
                       },
                       onSaved: (value){
                         _authData['lastName']= value!;
                         print(_authData['lastName']);
                       },
                     ),
                   ),
                   Container(
                     padding: EdgeInsets.all(20),
                     child: TextFormField(

                       //type of text
                       //keyboardType: TextInputType.,
                       style: TextStyle(color: white),
                       decoration: InputDecoration(labelText: "Enter username :",
                         enabledBorder: OutlineInputBorder(
                           borderSide: BorderSide(width: 2, color: Colors.white),
                           borderRadius: BorderRadius.circular(20.0),
                         ),
                         labelStyle: TextStyle(color: white),
                         hintText: "roro store/ roro_99",
                         hintStyle: TextStyle(
                             fontWeight: FontWeight.w900,
                             color: Colors.white,
                             fontStyle: FontStyle.italic),
                         prefixIcon: IconButton( icon: Icon(Icons.people_alt_outlined, color: Colors.white,), onPressed: () {  },),
                       ),
                       keyboardType: TextInputType.name,
                       cursorColor: white,
                       controller:   _usernameController,
                       validator: (val){
                         if(val== null) {
                           return " invalid Entry:(";
                         }   else{return null;} ;
                       },
                       onSaved: (value){
                         _authData['username']= value!;
                         print(_authData['username']);
                       },
                     ),
                   ),

                   Container(
                     padding: EdgeInsets.all(20),
                     child: TextFormField(
                       style: TextStyle(color: white),
                       decoration: InputDecoration(labelText: "Enter Email:",
                           enabledBorder: OutlineInputBorder(
                             borderSide: BorderSide(width: 2, color: Colors.white),
                             borderRadius: BorderRadius.circular(20.0),
                           ),
                         labelStyle: TextStyle(color: white),
                         hintText: "example@gmail.com",
                         hintStyle: TextStyle(
                             fontWeight: FontWeight.w900,
                             color: Colors.white,
                             fontStyle: FontStyle.italic),
                         suffixIcon: IconButton(onPressed: _emailController.clear, icon: Icon(Icons.cancel, color: Colors.white,),),
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
                      _authData['email']= value!;
                      print(_authData['email']);
                       },
                     ),
                   ),
                   Container(
                     padding: EdgeInsets.all(20),
                     child: TextFormField(
                       style: TextStyle(color: white),
                       decoration: InputDecoration(labelText: "Enter Password:", labelStyle: TextStyle(color: white),
                         enabledBorder: OutlineInputBorder(
                           borderSide: BorderSide(width: 2, color: Colors.white),
                           borderRadius: BorderRadius.circular(20.0),
                         ),
                         suffixIcon: IconButton(
                           onPressed: () {
                             setState(() { passwordVisible = !passwordVisible;});
                           },
                           icon: Icon(
                             passwordVisible ? Icons.visibility_off : Icons
                                 .visibility,
                             color: Colors.white,
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
                         _authData['password']= value!;
                         print(_authData['password']);
                       },
                     ),
                   ),
                   Container(
                     padding: EdgeInsets.all(20),
                     child: TextFormField(
                       style: TextStyle(color: white),
                       decoration: InputDecoration(labelText: "Confirm Password", labelStyle: TextStyle(color: white),
                         enabledBorder: OutlineInputBorder(
                           borderSide: BorderSide(width: 2, color: Colors.white),
                           borderRadius: BorderRadius.circular(20.0),
                         ),
                         suffixIcon: IconButton(
                           onPressed: () {
                             setState(() { passwordVisible2 = !passwordVisible2;});
                           },
                           icon: Icon(
                             passwordVisible2 ? Icons.visibility_off : Icons
                                 .visibility,
                             color: Colors.white,
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
                      Container(


                        padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: white,width: 2)
                            ),

                            child:
                                Column(
                                  children: [
                                    DropdownButton(

                                      borderRadius: BorderRadius.circular(20),
                                      hint: Text("select your Account"),
                                     isExpanded: true,
                                      value: valueChoose,
                                        onChanged: (newValue){
                                        setState(() {
                                          valueChoose = newValue as String?;

                                        });
                                        },
                                        items: listItems.map((valueItem) {
                                          return DropdownMenuItem(

                                              value: valueItem,
                                            child: Text(valueItem),
                                            enabled: true,
                                          );
                                        }).toList(),
                                    ),
                                  ],
                                )


                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                           child: Text('Sign Up'),
                           onPressed: _submit,
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

   CollectionReference users = FirebaseFirestore.instance.collection("users");


 
  void   _submit()     {
     //يتاكد من الاشياء الي داخل الفورم يتحقق منها عشان بعدها يخزنها
     if(!_formKey.currentState!.validate()){
       return ;
     }
     // حفظ الداتا الي تحقق منها داخل الفورم
         _formKey.currentState!.save();

     //انشاء حساب لليوزر جديد
   _createUser();
    //Navigator.pushReplacementNamed(context, HomePage.routeName);
    // addUser();
    // Fluttertoast.showToast(msg: "Account has Successfully created ");


  }

   Future addUser() async{
     return users.add({
       "email":_emailController.text,
       'name': _firstNameController.text,
       'last name': _lastNameController.text,
       'username': _usernameController.text,
       'password': _passwordController.text,
       'account type': valueChoose,


     }).then((value) =>
         print("user added!"));
   }
     Future<void> _createUser() async {
         try {
           UserCredential userCredential = await FirebaseAuth.instance
               .createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
           print("yeeeeeeeeeeessssssssssssss");
           addUser();
           Fluttertoast.showToast(msg: "Account has Successfully created ");
         } catch(err){
             showDialog(context: context, builder: (BuildContext context){
               return AlertDialog(
                 title: Text("Error"),
                 content: Text(err.toString()),
                 actions: [
                   TextButton(
                     child: Text("ok"),
                     onPressed: (){
                       Navigator.of(context).pop();
                     },
                   )
                 ],


               );
             });
       }

       // print("email: $_email, pass: $_password");
       // to create account and added to firebase
       // Null userCredential = await FirebaseAuth.instance
       //     .createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text).then((result){
       //       dbRef.child(result.user!.uid).set({
       //
       //         "email":_emailController.text,
       //         'firstName': _firstNameController.text,
       //         'lastName': _lastNameController.text,
       //         'username': _usernameController.text,
       //         'password': _passwordController.text,
       //
       //       });
       //         //   .then((res){
       //         // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage(uid: result.user!.uid)),
       //         // );
       //         Fluttertoast.showToast(msg: "Account has Successfully created ");
       //         print("yeeeeeeeeeeessssssssssssss");
       //
       //
       //       });
       // }).catchError((err){
       //   showDialog(context: context, builder: (BuildContext context){
       //     return AlertDialog(
       //       title: Text("Error"),
       //       content: Text(err.toString()),
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
       //
       // });
      // Navigator.pushNamed(context, '/');  زبط ولكن ما يعرض لي بيانات المستخدم

   }

}

