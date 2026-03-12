import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

export 'shared/constant.dart';
export 'shared/enum.dart';
export 'shared/extensions/extension.dart';
export 'shared/models/author/author.dart';
export 'shared/models/engagement_react/engagement_react.dart';
export 'shared/models/engagement_total/engagement_total.dart';
export 'shared/models/links/links.dart';
export 'shared/models/meta/meta.dart';
export 'shared/models/pagination_result/pagination_result.dart';
export 'shared/types.dart';
export 'shared/widgets/shared_widgets.dart';

class Utils {
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
      deviceName = iosInfo.name;
    } else if (Platform.isLinux) {
      // Handle Linux platform
      final linuxInfo = await deviceInfo.linuxInfo;
      deviceName = linuxInfo.name;
    } else if (Platform.isMacOS) {
      // Handle macOS platform
      final macOsInfo = await deviceInfo.macOsInfo;
      deviceName = macOsInfo.computerName;
    } else if (Platform.isWindows) {
      // Handle Windows platform
      final windowsInfo = await deviceInfo.windowsInfo;
      deviceName = windowsInfo.computerName;
    }

    return deviceName;
  }
}
