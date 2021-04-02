import 'package:flutter/material.dart';

class CustomOutlinedTextFormField extends StatelessWidget {
  final bool isPassword;
  final TextStyle style;
  final String hintText;
  final String text;
  final String validateEmptyText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLines;
  final int maxLength;
  final String labelText;
  final String suffixText;
  final ThemeData themeData;
  final bool required;
  final Color hintColor;
  final Color labelColor;
  final Color textColor;
  final bool enabled;
  final List<String> autoFillHints;
  final Function(String value) onChanged;
  final Function(String value) onFieldSubmitted;

  CustomOutlinedTextFormField({
    this.isPassword = false,
    this.style,
    this.hintText,
    this.text,
    this.validateEmptyText,
    this.controller,
    this.keyboardType,
    this.maxLines,
    this.maxLength,
    this.labelText,
    this.suffixText,
    this.themeData,
    this.required = true,
    this.hintColor,
    this.labelColor,
    this.textColor = Colors.black,
    this.enabled = true,
    this.onChanged,
    this.onFieldSubmitted,
    this.autoFillHints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TextFormField(
        obscureText: isPassword,
        style: TextStyle(fontSize: 14, color: textColor),
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: onFieldSubmitted,
        autofillHints: autoFillHints,
        validator: !required
            ? null
            : (String value) {
                if (value.isEmpty) {
                  return validateEmptyText;
                } else {
                  return null;
                }
              },
        maxLines: maxLines,
        maxLength: maxLength,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: hintColor),
          contentPadding: EdgeInsets.all(16),
          alignLabelWithHint: true,
          suffixText: suffixText,
          enabled: enabled,
          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
