import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';

class PleaseWaitView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: null,
      child: Container(
        color: Colors.black26,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          alignment: AlignmentDirectional.center,
          height: 400,
          color: Colors.black26,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                strokeWidth: 3,
              ),
              SizedBox(
                height: 20,
              ),
              CustomText(
                color: Colors.white,
                fontSize: fontSize18,
                alignment: AlignmentDirectional.center,
                text: 'pleaseWait'.tr,
              )
            ],
          ),
        ),
      ),
    );
  }
}
