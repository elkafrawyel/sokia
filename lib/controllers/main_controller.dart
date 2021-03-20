import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sokia_app/helper/language/language_model.dart';
import 'package:sokia_app/helper/local_storage.dart';

class MainController extends GetxController {
  var appLocaleCode = LocalStorage().getLanguage();

  var languageList = LanguageData.languageList();

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

  LanguageData getSelectedLanguage() {
    LanguageData lang;
    languageList.forEach((element) {
      if (element.languageCode == appLocaleCode) {
        lang = element;
        return;
      }
    });
    return lang;
  }

  changeLanguage(String languageCode) async {
    Get.updateLocale(Locale(languageCode));
    LocalStorage localStorage = LocalStorage();
    if (appLocaleCode == languageCode) {
      return;
    }
    if (languageCode == 'ar') {
      appLocaleCode = 'ar';
      localStorage.setLanguage('ar');
    } else {
      appLocaleCode = 'en';
      localStorage.setLanguage('en');
    }
    update();
  }
}
