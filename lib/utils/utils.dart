import 'dart:ui';

import 'package:get/get.dart';

export 'shared/constant.dart';
export 'shared/enum.dart';
export 'shared/extensions/extension.dart';
export 'shared/types.dart';
export 'shared/widgets/shared_widgets.dart';

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
