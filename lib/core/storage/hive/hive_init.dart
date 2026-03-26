import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kelasqna/kelasqna.dart';

Future<void> initHiveOpenBox() async {
  /// Initialize Hive.
  try {
    await Hive.initFlutter();
  } catch (e) {
    debugPrint("failed to initialize Hive");
  }

  /// Open Box

  // Open KelasQNA Box
  await Hive.openBox(kelasQNABoxKey);
  await Hive.openBox(intlBoxKey);
  await Hive.openBox(themeBoxKey);
  await Hive.openBox(authBoxKey);
  await Hive.openBox(sessionsBoxKey);
  await Hive.openBox(settingsBoxKey);
}
