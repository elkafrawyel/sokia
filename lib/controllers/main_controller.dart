import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sokia_app/helper/local_storage.dart';

class MainController extends GetxController {
  var appLocaleCode = LocalStorage().getLanguage();

  LatLng userLatLng;

  @override
  void onInit() {
    super.onInit();
    applyLanguage();
  }

  void applyLanguage() {
    Get.updateLocale(Locale(appLocaleCode));
    update();
  }

  changeLanguage(String languageCode) async {
    Get.updateLocale(Locale(languageCode));
    LocalStorage localStorage = LocalStorage();
    if (appLocaleCode == languageCode) {
      return;
    }
    appLocaleCode = languageCode;
    await localStorage.setLanguage(languageCode);
    update();
  }
}
