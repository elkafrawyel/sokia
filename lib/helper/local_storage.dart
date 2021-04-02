import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

class LocalStorage {
  static final String notifications = 'notifications';
  static final String languageKey = 'lang';
  static final String loginKey = 'login';
  static final String userId = 'userId';
  static final String uuid = 'uuid';
  static final String token = 'token';

  setLanguage(String languageCode) async {
    await GetStorage().write(languageKey, languageCode);
  }

  String getLanguage() {
    return GetStorage().read(languageKey) == null
        ? Get.deviceLocale.languageCode
        : GetStorage().read(languageKey);
  }

  bool isArabicLanguage() {
    return GetStorage().read(languageKey) == 'ar';
  }

  setString(String key, String value) async {
    await GetStorage().write(key, value);
  }

  String getString(String key) {
    return GetStorage().read(key);
  }

  setBool(String key, bool value) async {
    await GetStorage().write(key, value);
  }

  bool getBool(String key) {
    bool value = GetStorage().read(key);
    if (value == null) {
      if (key == notifications)
        return true;
      else
        return false;
    }
    return value;
  }

  setInt(String key, int value) async {
    await GetStorage().write(key, value);
  }

  int getInt(String key) {
    return GetStorage().read(key) == null ? 0 : GetStorage().read(key);
  }

  clear() {
    String language = getString(LocalStorage.languageKey);
    GetStorage().erase();
    setString(LocalStorage.languageKey, language);
  }

  Future<String> getUuid() async {
    if (LocalStorage().getString(LocalStorage.uuid) == null) {
      await GetStorage().write(LocalStorage.uuid, Uuid().v4());
    }
    return GetStorage().read(LocalStorage.uuid);
  }
}
