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
export 'shared/models/meta_profile/meta_profile.dart';
export 'shared/models/pagination_result/pagination_result.dart';
export 'shared/types.dart';
export 'shared/widgets/shared_widgets.dart';

class Utils {
  /// Retrieves the device name based on the current platform.
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

  /// Masks the [email] by obscuring the beginning of the username
  /// and showing only the last two characters before the domain.
  ///
  /// Example: `user52@gmail.com` becomes `*********52@gmail.com`.
  static String formatEmail(String email) {
    if (!email.contains('@')) return email;

    final emailParts = email.trim().split('@');
    final username = emailParts[0];
    final domain = emailParts[1];

    if (username.length <= 2) {
      return '*********$username@$domain';
    }

    final lastTwo = username.substring(username.length - 2);
    return '*********$lastTwo@$domain';
  }

  /// Generates initials from a given [name].
  ///
  /// It takes the first character of the first three words and converts them to uppercase.
  /// If the name is empty, it returns '?'.
  ///
  /// Example:
  /// - `John Doe` -> `JD`
  /// - `John Fitzgerald Kennedy` -> `JFK`
  /// - `Flutter` -> `F`
  static String formatInitialName(String name) {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();

    // Note: This logic assumes there are at least 3 parts for the third index.
    // If name has only 2 parts, it might throw a RangeError.
    // Let's refine it slightly to be safer.
    String initials = '';
    for (var i = 0; i < parts.length && i < 3; i++) {
      if (parts[i].isNotEmpty) {
        initials += parts[i][0];
      }
    }
    return initials.toUpperCase();
  }
}
