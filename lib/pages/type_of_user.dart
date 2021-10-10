import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_product/pages/login.dart';

import 'home.dart';

class TypeOfUser extends StatefulWidget {
  const TypeOfUser({Key? key}) : super(key: key);

  @override
  _TypeOfUserState createState() => _TypeOfUserState();
}

class _TypeOfUserState extends State<TypeOfUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(

        backgroundColor: const Color(0xffFFBCBC,) ,
        title: const Text('choose Mode' ),
      ),*/

      body:  Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://thumbs.dreamstime.com/b/helping-each-other-career-ladder-business-concept-being-teacher-leader-supervisor-two-men-moving-up-helping-177642849.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black87,BlendMode.darken),
          ),

        ),
         // margin: EdgeInsets.all(10.0),


          alignment: Alignment.center,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              SizedBox(
                height: 150,

                  child: Text("\" Choose Your Enter Mode \" ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 30))),

              TextButton.icon(
                onPressed: (){
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) => const Login()));
                },
                icon: Icon(Icons.person_sharp,color: Colors.white),
                label: Text("Log in ",style: TextStyle(color: Colors.white),),

                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 82, 166, 189)),
              ),
              ),
            /*  TextButton.icon(
                onPressed: (){
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) => const Login()));
                },
                icon: Icon(Icons.shopping_bag,color: Colors.white),
                label: Text("Enter as a Productive Family",style: TextStyle(color: Colors.white),),

                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xffFFBCBC))),
              ),*/
              TextButton.icon(
                onPressed: (){
                  // Navigator.push(
                  //     context, MaterialPageRoute(
                  //     builder: (context) =>  HomePage()));
                },
                icon: Icon(Icons.perm_identity_sharp,color: Colors.white),
                label: Text("Enter as a Guest",style: TextStyle(color: Colors.white),),

                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 82, 166, 189))),
              ),


            ],
          ),
        ),
      );



  }
}

