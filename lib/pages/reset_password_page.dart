import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:get/get.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController _controllerEmail = TextEditingController();


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
          "Reset password ",
          style: TextStyle(fontSize: 30,color: black ),
        ),
        toolbarHeight: 100,
      ),
      body:Container(
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


                          TextField(

                            keyboardType: TextInputType.visiblePassword,
                            controller: _controllerEmail,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 2,color:basicColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labelText: "Enter your email :",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.w400, fontStyle: FontStyle.italic,color: black),


                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children:[ Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: MaterialButton(
                                  color: basicColor,
                                  child: Text(
                                    " return to login ",
                                    style: TextStyle(color: black),
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                              ),
                                MaterialButton(
                                    onPressed:
                                    (){
                                      resetPassword(_controllerEmail.text);
                                    },
                                child: Text("Send password reset"),
                                ),

                  ]
                            ),
                          SizedBox(height: 20,),




                        ]),
                  ),
                )
              ]
          ),

      ),
    );

  }
  Future resetPassword(String email)async{
    try{
      return await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
        final snackBar = SnackBar
          (duration: Duration(seconds: 3), content: Text(" reset link sent ",
          style: TextStyle(color: white, fontSize: 25),), backgroundColor: black,);

        // updateProduct();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Get.back();
      });

    }catch(e){
      final snackBar = SnackBar
        (duration: Duration(seconds: 3), content: Text("enter your email!! ",
        style: TextStyle(color: Colors.white,
            fontSize: 25),), backgroundColor: Colors.blueGrey,);

      // updateProduct();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print("error: $e");
    }

  }
}
