import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final AlignmentDirectional alignment;
  final int maxLines;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  CustomText({
    this.text = '',
    this.color = Colors.black,
    this.fontSize = 14,
    this.alignment = AlignmentDirectional.topStart,
    this.maxLines = 1,
    this.fontWeight,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.headline6.copyWith(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
        textAlign: textAlign,
      ),
    );
  }
}
