import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
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

  static Future<String> getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceName = "Unknown";

    if (kIsWeb) {
      // Handle web platform
      final webInfo = await deviceInfo.webBrowserInfo;
      deviceName = webInfo.appName ?? "Web Browser";
    } else if (Platform.isAndroid) {
      // Handle Android platform
      final androidInfo = await deviceInfo.androidInfo;
      // Combine manufacturer and model for a more descriptive name
      deviceName = "${androidInfo.manufacturer} ${androidInfo.model}";
    } else if (Platform.isIOS) {
      // Handle iOS platform
      final iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.name ?? iosInfo.model ?? "iOS Device";
    } else if (Platform.isLinux) {
      // Handle Linux platform
      final linuxInfo = await deviceInfo.linuxInfo;
      deviceName = linuxInfo.name ?? "Linux Device";
    } else if (Platform.isMacOS) {
      // Handle macOS platform
      final macOsInfo = await deviceInfo.macOsInfo;
      deviceName = macOsInfo.computerName ?? "macOS Device";
    } else if (Platform.isWindows) {
      // Handle Windows platform
      final windowsInfo = await deviceInfo.windowsInfo;
      deviceName = windowsInfo.computerName ?? "Windows Device";
    }

    return deviceName;
  }
}
