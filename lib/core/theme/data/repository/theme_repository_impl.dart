import 'package:flutter/material.dart';
import 'package:kelasqna/core/theme/data/datasources/theme_local_data_source.dart';
import 'package:kelasqna/core/theme/domain/repository/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource _localDataSource;

  ThemeRepositoryImpl(this._localDataSource);

  @override
  ThemeMode getThemeMode() => _localDataSource.getThemeMode();

  @override
  Future<void> setThemeMode(ThemeMode themeMode) =>
      _localDataSource.setThemeMode(themeMode);
}
