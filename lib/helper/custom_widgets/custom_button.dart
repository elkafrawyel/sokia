import 'package:flutter/material.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color colorBackground;
  final Color colorText;
  final double fontSize;
  final double elevation;
  final bool underLineText;
  final double radius;

  CustomButton({
    @required this.text,
    @required this.onPressed,
    this.colorBackground,
    this.colorText,
    this.fontSize = fontSize16,
    this.elevation = 5.0,
    this.underLineText = false,
    this.radius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: Colors.white,
        backgroundColor: colorBackground,
        onSurface: Colors.grey,
        elevation: elevation,
        // side: BorderSide(color: Colors.red, width: 2),
        // shape: const BeveledRectangleBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(10))),
        shape: radius == 0
            ? const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ),
              )
            : const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
      ),
      onPressed: onPressed,
      child: !underLineText
          ? CustomText(
              text: text,
              color: colorText,
              fontSize: fontSize,
              alignment: AlignmentDirectional.center,
            )
          : Text(
              text,
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: colorText,
                fontSize: fontSize,
              ),
            ),
    );
  }
}
