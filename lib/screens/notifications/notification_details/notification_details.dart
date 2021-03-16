import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/data/responses/notifications_response.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/main_screen.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';

class NotificationDetailsScreen extends StatelessWidget {
  final NotificationModel notificationModel;

  NotificationDetailsScreen({this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      title: 'notification'.tr,
      pageBackground: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(top: 10, start: 10, end: 10),
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(0)),
                child: Text(
                  notificationModel.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomText(
                text: notificationModel.body,
                fontSize: fontSize16,
                maxLines: 100,
              ),
            )
          ],
        ),
      ),
    );
  }
}
