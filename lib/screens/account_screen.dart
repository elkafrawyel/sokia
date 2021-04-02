import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/controllers/user_controller.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/main_screen.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/screens/change_password_screen.dart';
import 'package:sokia_app/screens/notification_settings_screen.dart';
import 'package:sokia_app/screens/profile_screen.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScreen(
      title: 'profile'.tr,
      pageBackground: kBackgroundColor,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => ProfileScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    color: Colors.grey.shade700,
                    text: 'name-email-phone'.tr,
                  ),
                ),
              ),
              Visibility(
                visible: Get.find<UserController>().user.socialType ==null,
                child: Divider(
                  thickness: 1,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => ChangePasswordScreen());
                },
                child: Visibility(
                  visible: Get.find<UserController>().user.socialType ==null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      text: 'password'.tr,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => NotificationSettingsScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    text: 'notifications'.tr,
                    color: Colors.grey.shade700,
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
