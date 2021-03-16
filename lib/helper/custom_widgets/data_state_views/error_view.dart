import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';

class ErrorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset(errorImage),
          CustomText(
            text: 'error'.tr,
            alignment: AlignmentDirectional.center,
            fontSize: fontSize18,
            color: Colors.red,
          )
        ],
      ),
    );
  }
}

const errorImage = 'src/json/error.json';
