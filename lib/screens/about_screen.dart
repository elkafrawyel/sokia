import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/main_screen.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/screens/about_app_screen.dart';
import 'package:sokia_app/screens/terms_screen.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScreen(
      title: 'about'.tr,
      pageBackground: kBackgroundColor,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        color: Colors.grey.shade500,
                        text: 'appVersion'.tr,
                      ),
                      CustomText(
                        text: '1.0.1',
                        color: kPrimaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => AboutAppScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    text: 'about'.tr,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => TermsScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    text: 'terms'.tr,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              Divider(
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
