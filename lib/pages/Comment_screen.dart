import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:my_product/color/my_colors.dart';

class CommentsPage extends StatefulWidget{
  @override
  createState()=> CommentPageState();
}



class CommentPageState extends State<CommentsPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        title: Text("Comments",style: TextStyle(color: black)),
        backgroundColor: basicColor,
      ),
      body: Column(children: <Widget>[Expanded(child: _buildCommentsList()),
      TextField(
        onSubmitted:(String submitted){
          _addComments(submitted);}
          ,decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        hintText: "add comment",
      ),
      )
      ],),
    ) ;
  }


//to display comments
  Widget _buildCommentsList([String comment]){
    return ListView.builder(
        itemBuilder: (context,index){
          if (index< _comments.length){
            return _buildCommentsList(
                _comments[index]);}});}

            //list عادي بس عشان تضيف الكومنت طبيعي يعني
  List <String> _comments = ["too delicios","nice price","i love this product"];

  //عشان يعمل اد للكومنت بتاع اليوزر فييين؟ف اللسته اللي فوق اكيد بدهاش
  _addComments(String val) {
          setState((){_comments.add(val);});}
//اعتقد الشي دا ما منو فايده خااالص
  Widget _buildCommentsItem(String comments){
    return ListTile(
      title: Text("comments",style: TextStyle(color:black),),);
  }
}