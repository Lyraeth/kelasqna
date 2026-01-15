import 'package:flutter/material.dart';
import 'package:kelasqna/core/theme/domain/repository/theme_repository.dart';

class ThemeUseCase {
  final ThemeRepository _themeRepository;

  ThemeUseCase(this._themeRepository);

  ThemeMode getThemeMode() => _themeRepository.getThemeMode();

  Future<void> setThemeMode(ThemeMode themeMode) =>
      _themeRepository.setThemeMode(themeMode);
}
