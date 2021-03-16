import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/controllers/main_controller.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/main_screen.dart';
import 'package:sokia_app/helper/local_storage.dart';

class NotificationSettingsScreen extends StatelessWidget {
  //radio switch value
  final String on = 'working'.tr;
  final String off = 'notWorking'.tr;

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      title: 'notifications'.tr,
      pageBackground: kBackgroundColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)),
                child: Text('notifications'.tr),
              ),
            ),
            Expanded(
              child: GetBuilder<MainController>(
                builder: (controller) => Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Radio(
                            //if value and groupValue are the same it will be selected otherwise not selected
                            value: true,
                            activeColor: kPrimaryColor,
                            groupValue: LocalStorage()
                                .getBool(LocalStorage.notifications),
                            onChanged: (value) {
                              LocalStorage()
                                  .setBool(LocalStorage.notifications, true);
                              Get.find<MainController>().update();
                            },
                          ),
                          Text(on, style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: false,
                            activeColor: kPrimaryColor,
                            groupValue: LocalStorage()
                                .getBool(LocalStorage.notifications),
                            onChanged: (value) {
                              LocalStorage()
                                  .setBool(LocalStorage.notifications, false);
                              Get.find<MainController>().update();
                            },
                          ),
                          Text(off, style: TextStyle(fontSize: 14)),
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
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
