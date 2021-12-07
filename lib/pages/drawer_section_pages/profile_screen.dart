import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:get/get.dart';
import 'package:my_product/pages/chat/database_methods.dart';

import '../home_page.dart';

class ProfileScreen extends StatefulWidget {
  //const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();

}

class _ProfileScreenState extends State<ProfileScreen> {

  // var username; // for display to user

  // TextEditingController _firstNameController = TextEditingController();
  // TextEditingController _lastNameController = TextEditingController();
  // TextEditingController _userNameController = TextEditingController();


  var firebaseUser = FirebaseAuth.instance.currentUser;
  CollectionReference usersRef =  FirebaseFirestore.instance.collection('users');
  CollectionReference usernameRefComment = FirebaseFirestore.instance.collection('comments');

  var userEmail;
  var docData; // for printing
  var  myFirstName, myLastName, myUsername ;

  getUserData() async {
    //اجيب بيانات دوكيمنت واحد فقط
    DocumentReference documentReference = FirebaseFirestore.instance.collection(
        'users').doc(firebaseUser.uid);
    //get will return docs Query snapshot
    await documentReference.get().then((userDocu) {
      //value.data is the full fields for this doc
      if (userDocu.exists) {
        setState(() {
          docData = userDocu.data();
          userEmail = docData['email'];
          // username = docData['username'];
          myFirstName= docData['first name'];
          myLastName = docData['last name'];
          myUsername= docData['username'];
          // print(value.id);
        });
        print(docData['uid']);
        //print(docData['username']);
        print(docData['email']);
        print(myFirstName);
      } else {}
    });
  }
  @override
  void initState() {
    //if(firebaseUser != null) {
      getUserData();

    //}
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
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
            "My profile ",
            style: TextStyle(fontSize: 30,color: black ),
          ),
          toolbarHeight: 100,
        ),
        backgroundColor: basicColor,
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).snapshots() ,
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Container(
                  height: MediaQuery.of(context).size.height - 120,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        //bottomRight: Radius.circular(90),
                      )),child: Center(child: CircularProgressIndicator(),));
            }
            else if( snapshot.connectionState==ConnectionState.waiting){
              return Container(
                  height: MediaQuery.of(context).size.height - 120,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        //bottomRight: Radius.circular(90),
                      )),child: Center(child: CircularProgressIndicator(),));

            }else{
              return Container(
                height: MediaQuery.of(context).size.height - 120,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                      //bottomRight: Radius.circular(90),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(80.0),
                          child: Center(child: Container(child:
                          Text(" Edit your profile",style: TextStyle(fontSize: 30),),)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("enter new First name:"),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black54),
                          decoration: InputDecoration(
                            // labelText: "Enter Your First Name:",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2, color: basicColor),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelStyle: TextStyle(color: black),
                            hintText: myFirstName,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: black,
                                fontStyle: FontStyle.italic),
                            prefixIcon: IconButton( icon: Icon(Icons.person_pin_outlined, color:black,), onPressed: () {  },),
                          ),
                          keyboardType: TextInputType.name,
                          cursorColor: black,
                         // controller: _firstNameController,
                          validator: (val){
                            if( val.isEmpty || val.length <2) {
                              return " please enter longer name :(";
                            }
                            else if( val == docData['first name']){
                              return " same old first name ";}


                          },
                          onSaved: (value){

                            myFirstName = value;
                          },


                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("enter new Last name:"),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black54),
                          decoration: InputDecoration(
                            //  labelText: "Enter Your Last Name:",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2, color: basicColor),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelStyle: TextStyle(color: black),
                            hintText: myLastName,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: black,
                                fontStyle: FontStyle.italic),
                            prefixIcon: IconButton( icon: Icon(Icons.person_pin_outlined, color:black,), onPressed: () {  },),
                          ),
                          keyboardType: TextInputType.name,
                          cursorColor: black,
                         // controller: _lastNameController,
                          validator: (val){
                            if( val.length < 2 || val.isEmpty ) {
                              return " please enter longer name :(";
                            }   else if (val == docData['last name']){
                              return " same old last name ";} ;

                          },
                          onSaved: (value){

                            myLastName = value;
                          },

                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("enter new username:"),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black54),
                          decoration: InputDecoration(
                            // labelText: "Enter username :",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2, color: basicColor),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelStyle: TextStyle(color: black),
                            hintText: myUsername,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: black,
                                fontStyle: FontStyle.italic),
                            prefixIcon: IconButton( icon: Icon(Icons.person_pin_outlined, color:black,),),
                          ),
                          keyboardType: TextInputType.name,
                          cursorColor: black,
                          //controller: _userNameController,
                          validator: (val){
                            if( val.length < 2 || val.isEmpty) {
                              return " please enter longer name :(";
                            }   else if ( val == docData['username']){
                              return " same old username";}
                            else if(!val.contains('.')&& !val.contains('_')&&!val.contains('-'))
                            {
                            return " add any symbols";
                            }
                            else if (!val.contains(RegExp(r'[0-9]'))) {
                            return " you should add numbers ";}
                            else null; 


                          },
                          onSaved: (value){

                            myUsername = value;
                          },

                        ),
                        SizedBox(height: 50,),

                        InkWell(
                          child: Column(
                            children: [
                              Icon(Icons.change_circle,size: 50,),
                              Text("press to update your information"),
                            ],
                          ),
                          onTap: (){
                            if(!_formKey.currentState.validate()){
                              print("updated failed");

                            }else{
                              final snackBar =SnackBar
                                (duration: Duration(seconds: 2),content: Text(" Information is updated ",
                                style: TextStyle(color: white,fontSize: 20),),backgroundColor: black,);
                              _formKey.currentState.save();
                              updateUserInfo();

                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              //Get.off(()=> HomePage());
                              Get.back();
                              print("updated done!");

                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
              //Center(child: Text(snapshot.data['last name']));
            }
          },

        )

    );
  }

  Future updateUserInfo()async{
    // DocumentReference usersRef =  FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid);
    usersRef.doc(firebaseUser.uid).update({
    'first name': myFirstName.trim(),
    'last name': myLastName.trim(),
    'username':myUsername.trim(),
    }).then((value) {

      SnackBar(content: Text(" Information is updated ",style: TextStyle(color: white,fontSize: 30),),backgroundColor: black,);
      print("user updated");});




  }
}
