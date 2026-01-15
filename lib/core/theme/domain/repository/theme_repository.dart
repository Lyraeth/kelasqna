import 'package:flutter/material.dart';

abstract class ThemeRepository {
  ThemeMode getThemeMode();

  Future<void> setThemeMode(ThemeMode themeMode);
}
