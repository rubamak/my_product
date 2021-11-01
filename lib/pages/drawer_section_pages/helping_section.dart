import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/widgets/custom_text.dart';

class HelpingSection extends StatelessWidget {
  const HelpingSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      alignment: Alignment.center,
      padding: EdgeInsets.all(20.0),
      child: CustomText(
          text: "For any Questions or Problems Contact us on wwww....", size: 30.0, colors: black, weightFont: FontWeight.w600,

      )
    );
  }
}
