import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomTextFormField extends StatelessWidget {
  final String text, hintText, validatorText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final int lines;

  CustomTextFormField(
      {this.text,
      this.hintText,
      this.obscureText = false,
      this.validatorText,
      this.keyboardType = TextInputType.text,
      this.controller,
      this.lines = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomText(
            text: text,
            fontSize: 14,
            color: Colors.grey.shade900,
          ),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            maxLines: lines,
            validator: (String value) {
              if (value.isEmpty) {
                return validatorText;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey),
                fillColor: Colors.white),
          )
        ],
      ),
    );
  }
}
