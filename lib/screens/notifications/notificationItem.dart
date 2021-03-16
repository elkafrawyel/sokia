import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/data/responses/notifications_response.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/screens/notifications/notification_details/notification_details.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notificationModel;

  NotificationItem({this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => NotificationDetailsScreen(
              notificationModel: notificationModel,
            ));
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 5, end: 5),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                CustomText(
                  text: notificationModel.title,
                  fontSize: fontSize16,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    text: notificationModel.body,
                    fontSize: fontSize14,
                    color: Colors.grey.shade500,
                    maxLines: 3,
                  ),
                ),
                CustomText(
                  text: CommonMethods()
                      .timeAgoSinceDate(notificationModel.unixTime),
                  fontSize: fontSize14,
                  alignment: AlignmentDirectional.bottomEnd,
                  color: Colors.grey.shade500,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
