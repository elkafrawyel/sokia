import 'package:flutter/material.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color colorBackground;
  final Color colorText;
  final double fontSize;

  CustomButton(
      {@required this.text,
      @required this.onPressed,
      this.colorBackground,
      this.colorText,
      this.fontSize = fontSize16});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: Colors.white,
        backgroundColor: colorBackground,
        onSurface: Colors.grey,
        elevation: 5,
        // side: BorderSide(color: Colors.red, width: 2),
        // shape: const BeveledRectangleBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(10))),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      onPressed: onPressed,
      child: CustomText(
        text: text,
        color: colorText,
        fontSize: fontSize,
        alignment: AlignmentDirectional.center,
      ),
    );
  }
}
