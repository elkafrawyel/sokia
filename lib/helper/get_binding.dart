import 'package:get/get.dart';
import 'package:sokia_app/controllers/main_controller.dart';

class GetBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MainController(), permanent: true);
  }
}
