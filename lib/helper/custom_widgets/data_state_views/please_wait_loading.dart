import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';

class PleaseWaitView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
          SizedBox(
            height: 20,
          ),
          CustomText(
            color: Colors.black,
            alignment: AlignmentDirectional.center,
            text: 'pleaseWait'.tr,
          )
        ],
      ),
    );
  }
}
