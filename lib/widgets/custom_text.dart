import 'package:flutter/material.dart';

// this class is for any Text class

class CustomText extends StatelessWidget {

   final String text ;
   final double size ;
   final Color colors;
   final FontWeight weightFont;

  CustomText({ this.text,  this.size, this.colors, this.weightFont});


  @override
  Widget build(BuildContext context) {
    // if size is null it be 16 as default
    return
      Text(text ,style: TextStyle(
        fontSize: size  ,color: colors , fontWeight: weightFont )
    );

  }
}
