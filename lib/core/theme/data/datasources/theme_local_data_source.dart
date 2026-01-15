import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:kelasqna/core/storage/hive/hive_storage_label.dart';

abstract class ThemeLocalDataSource {
  ThemeMode getThemeMode();

  Future<void> setThemeMode(ThemeMode themeMode);
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  @override
  ThemeMode getThemeMode() {
    final value = Hive.box(themeBoxKey).get(themeCurrentThemeModeKey);

    switch (value) {
      case "light":
        return ThemeMode.light;
      case "dark":
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  @override
  Future<void> setThemeMode(ThemeMode themeMode) {
    final value = switch (themeMode) {
      ThemeData.light => "light",
      ThemeData.dark => "dark",
      _ => "system",
    };

    return Hive.box(themeBoxKey).put(themeCurrentThemeModeKey, value);
  }
}
