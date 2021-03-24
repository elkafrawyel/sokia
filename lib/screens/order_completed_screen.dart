import 'package:flutter/material.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/helper/local_storage.dart';
import 'package:get/get.dart';
import 'package:sokia_app/screens/home/home_screen.dart';

class OrderCompletedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        toolbarHeight: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Image.asset(
              'src/images/order_confirmed.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    fontSize: fontSize18,
                    color: Colors.white,
                    alignment: AlignmentDirectional.center,
                    text: 'orderConfirmed'.tr,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: CustomText(
                      fontSize: fontSize14,
                      color: Colors.white,
                      maxLines: 5,
                      alignment: AlignmentDirectional.center,
                      textAlign: TextAlign.center,
                      text: 'orderCompleteMessage'.tr,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white),
                        child: IconButton(
                          icon: Icon(
                            LocalStorage().isArabicLanguage()
                                ? Icons.arrow_back
                                : Icons.arrow_forward,
                            color: kPrimaryColor,
                          ),
                          onPressed: () {
                            // load my orders
                            Get.offAll(() => HomeScreen());
                          },
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CustomText(
                        fontSize: fontSize16,
                        color: Colors.white,
                        alignment: AlignmentDirectional.center,
                        text: 'goHome'.tr,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
