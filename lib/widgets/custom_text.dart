import 'package:flutter/material.dart';

// this class is for any Text class

class CustomText extends StatelessWidget {

  late final String text ;
  late final double size ;
  late final Color colors;
  late final FontWeight weightFont;

  CustomText({required this.text, required this.size,required this.colors,required this.weightFont});


  @override
  Widget build(BuildContext context) {
    // if size is null it be 16 as default
    return Text(text ,style: TextStyle(
        fontSize: size  ,color: colors , fontWeight: weightFont )
    );

  }
}
