import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/controllers/home_controller.dart';
import 'package:sokia_app/controllers/main_controller.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/main_screen.dart';

import 'local_storage.dart';

class LanguageScreen extends StatelessWidget {
  //radio switch value
  final String arabic = 'العربية';
  final String english = 'English';
  final String urdu = 'Urdu';
  final String persian = 'Persian';

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      title: 'appLanguage'.tr,
      pageBackground: kBackgroundColor,
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)),
                child: Text('appLanguage'.tr),
              ),
            ),
            Expanded(
              child: GetBuilder<MainController>(
                builder: (controller) =>
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Radio(
                                //if value and groupValue are the same it will be selected otherwise not selected
                                value: 'ar',
                                activeColor: kPrimaryColor,
                                groupValue: LocalStorage()
                                    .getString(LocalStorage.languageKey),
                                onChanged: (value) {
                                  Get.find<MainController>().changeLanguage(
                                      'ar');
                                  Get.find<HomeController>().onInit();
                                },
                              ),
                              Text(arabic, style: TextStyle(fontSize: 14)),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 'en',
                                activeColor: kPrimaryColor,
                                groupValue: LocalStorage()
                                    .getString(LocalStorage.languageKey),
                                onChanged: (value) {
                                  Get.find<MainController>().changeLanguage(
                                      'en');
                                  Get.find<HomeController>().onInit();
                                },
                              ),
                              Text(english, style: TextStyle(fontSize: 14)),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 'ur',
                                activeColor: kPrimaryColor,
                                groupValue: LocalStorage()
                                    .getString(LocalStorage.languageKey),
                                onChanged: (value) {
                                  Get.find<MainController>().changeLanguage(
                                      'ur');
                                  Get.find<HomeController>().onInit();
                                },
                              ),
                              Text(urdu, style: TextStyle(fontSize: 14)),
                            ],
                          ), Row(
                            children: [
                              Radio(
                                value: 'fa',
                                activeColor: kPrimaryColor,
                                groupValue: LocalStorage()
                                    .getString(LocalStorage.languageKey),
                                onChanged: (value) {
                                  Get.find<MainController>().changeLanguage(
                                      'fa');
                                  Get.find<HomeController>().onInit();
                                },
                              ),
                              Text(persian, style: TextStyle(fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                    ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Image.asset(
                'src/images/bottom_bg.png',
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
