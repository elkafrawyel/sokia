import 'package:get/get.dart';
import 'package:sokia_app/helper/language/ur.dart';

import 'ar.dart';
import 'en.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ar': ar,
        'ur': ur,
      };
}
