import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child("Users");
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              controller: userNameController,
              decoration: InputDecoration(
                labelText: "Enter User Name",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter User Name';
                }
                return null;
              },
            ),
          ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Enter Email",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Email';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Enter password",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter pass';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    registerToFb();
                  }
                },
                child: Text('Submit'),
              ),
        ])));
  }

  void registerToFb() {
    firebaseAuth
        .createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text)
        .then((result) {
      dbRef.child(result.user!.uid).set({
        "email": emailController.text,
        "username": userNameController.text,
        // "name": nameController.text
      }).then((res) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });
    }).catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });

  }
}
