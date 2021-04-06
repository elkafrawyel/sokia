import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/controllers/notifications_controller.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/data_state_views/empty_view.dart';
import 'package:sokia_app/helper/custom_widgets/data_state_views/loading_view.dart';
import 'package:sokia_app/helper/custom_widgets/main_screen.dart';

import 'notificationItem.dart';

class NotificationsScreen extends StatelessWidget {
  final controller = Get.put(NotificationsController());

  NotificationsScreen() {
    controller.getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      title: 'notification'.tr,
      pageBackground: kBackgroundColor,
      body: RefreshIndicator(
        onRefresh: () {
          controller.onInit();
          return Future.value();
        },
        child: GetBuilder<NotificationsController>(
          builder: (controller) => controller.loading
              ? LoadingView()
              : controller.empty
                  ? EmptyView(
                      emptyViews: EmptyViews.Magnifier,
                      textColor: Colors.black,
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return NotificationItem(
                          notificationModel:
                              controller.notificationList[index],
                        );
                      },
                      itemCount: controller.notificationList.length,
                    ),
        ),
      ),
    );
  }
}
