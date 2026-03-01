import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource _localDataSource;

  ThemeRepositoryImpl(this._localDataSource);

  @override
  ThemeMode getThemeMode() => _localDataSource.getThemeMode();

  @override
  Future<void> setThemeMode(ThemeMode themeMode) =>
      _localDataSource.setThemeMode(themeMode);
}
