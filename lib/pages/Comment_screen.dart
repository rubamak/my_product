
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:my_product/color/my_colors.dart';


class CommentsPage extends StatefulWidget{
  bool isLoading = false;
  @override
 State<CommentsPage> createState()=> CommentPageState();
  var productId ;
  CommentsPage({this.productId});
}



class CommentPageState extends State<CommentsPage>{

  var CommentsController = TextEditingController()..text = "";


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var firebaseUser =  FirebaseAuth.instance.currentUser;

  QuerySnapshot <Map<String, dynamic>> commments;


  @override
  void initState() {
    getComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        toolbarHeight: 100,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color:black),
          onPressed: () {
            Get.back();
          },
          // color: black,
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 1),
          child: Text(
            "Add comment",
            style: TextStyle(color: black, fontSize: 25),
          ),
        ),
        backgroundColor: basicColor,
      ),
      body: Container(
        color: basicColor,
    child: Container(
      height: MediaQuery.of(context).size.height - 100,
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(120),
          )),
     //it was here 
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: ListView(
            children: [
              SizedBox(height: 50,),
              TextFormField(
                style: TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: "write your comment here",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                controller: CommentsController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 15),
              if(widget.isLoading)
                Center(child: CircularProgressIndicator(),),
              if(!widget.isLoading)
                Container(
                  width: double.infinity,
                  child:ElevatedButton(
                      child: Text("Add Your Comment"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),),
                      onPressed:  () {
                        addComments();
                      }

                  ),
                ),
            ],
          ),
        ),
      ),
    ),),
    );
  }

  Future addComments()async {
    FocusScope.of(context).unfocus();
    var commentRef = await FirebaseFirestore.instance.collection('comments');
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        widget.isLoading = true;
      });

      try {
        commentRef.doc(widget.productId).set({
          'uid': firebaseUser.uid,
          'product id': widget.productId,
          'Comment': CommentsController.text,
          'addedAt': Timestamp.now(),
        }).then((value) {
          print('comment added');
          Fluttertoast.showToast(msg: 'comment added',);
          Get.off(() => CommentsPage());
          //Navigator.of(context).pop();
        });
      } catch (e) {
        print("error when adding comment: $e");
        setState(() {
          widget.isLoading = false;
        });
      }
    }
  }


    var docData;

    getComments() async {
      //اجيب بيانات دوكيمنت واحد فقط
      //get will return docs Query snapshot
      await FirebaseFirestore.instance.collection('comments')
          .doc(widget.productId)
          .get()
          .then((value) async {
        //value.data is the full fields for this doc
        if (value.exists) {
          setState(() {
            docData = value;
            print(docData.id);
            print("-=========================================");
            print(docData['Comment']);
            //print(commments);
          });
          // await FirebaseFirestore.instance.collection('products')
          //     .where('product id', isEqualTo: docData.id ).get().then((doc) {
          //   if (doc != null && doc.docs.isEmpty == false) {
          //     setState(() {
          //       commments = doc;
          //     });
          //   }
          // });
        } else {
         // return Text(docData['Comment']);
        }
      });
    }

  }





