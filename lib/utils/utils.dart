import 'dart:ui';

import 'package:get/get.dart';

class Utils {
  static String getTranslatedLabel(String labelKey) {
    return labelKey.tr.trim();
  }

  static Locale getLocaleFromLanguageCode(String languageCode) {
    List<String> result = languageCode.split("-");
    return result.length == 1
        ? Locale(result.first)
        : Locale(result.first, result.last);
  }
}
