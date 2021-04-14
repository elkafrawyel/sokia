import 'package:get/get.dart';
import 'package:sokia_app/controllers/main_controller.dart';
import 'package:sokia_app/controllers/notifications_controller.dart';

class GetBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MainController(), permanent: true);

    //perfect example of disposing the controller must add binding class in to statement
    Get.lazyPut(() => NotificationsController());
  }
}
