import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/controllers/user_controller.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/get_binding.dart';
import 'package:sokia_app/screens/notifications/notifications_screen.dart';

class UserInfo extends StatelessWidget {
  final isLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: 10, end: 10, top: 30),
      alignment: AlignmentDirectional.topStart,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset(
                  'src/images/logo.png',
                  fit: BoxFit.fill,
                ),
                radius: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'labelWelcome'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GetBuilder<UserController>(
                    builder: (controller) => Text(
                      controller.user != null ? controller.user.name : '',
                      style:
                          TextStyle(fontSize: fontSize14, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              Get.to(() => NotificationsScreen(), binding: GetBinding());
            },
            icon: Icon(
              Icons.notifications_active,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
