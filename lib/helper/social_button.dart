import 'package:flutter/material.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';

class SocialButton extends StatelessWidget {
  final String imageAsset;
  final Function onTap;
  final String text;

  SocialButton(
      {@required this.imageAsset, @required this.onTap, @required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: Padding(
        padding:
            const EdgeInsetsDirectional.only(start: 20, end: 20, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  imageAsset,
                  width: 50,
                  height: 50,
                ),
              ),
              Expanded(
                child: CustomText(
                  text: text,
                  fontSize: 14,
                  alignment: AlignmentDirectional.centerStart,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
