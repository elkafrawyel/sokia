import 'package:get/get.dart';
import 'package:sokia_app/api/api_service.dart';
import 'package:sokia_app/data/responses/notifications_response.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/data_states.dart';

class NotificationsController extends GetxController {
  List<NotificationModel> notificationList = [];
  bool loading = false;
  bool error = false;
  bool empty = false;


  getNotifications() async {
    loading = true;
    update();
    notificationList.clear();
    await ApiService().getNotifications(
      state: (dataState) {
        if (dataState is SuccessState) {
          notificationList.addAll((dataState.data as List<NotificationModel>));
          loading = false;
          empty = notificationList.isEmpty;
          update();
        } else if (dataState is ErrorState) {
          loading = false;
          error = true;
          update();
        } else if (dataState is NoConnectionState) {
          loading = false;
          update();
          CommonMethods().goOffline();
        }
      },
    );
  }
}
