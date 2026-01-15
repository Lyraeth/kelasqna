import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/core/internationalization/domain/repository/intl_repository.dart';
import 'package:kelasqna/core/theme/domain/repository/theme_repository.dart';
import 'package:kelasqna/utils/utils.dart';

part 'app_bloc.freezed.dart';
part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final IntlRepository _intlRepository;
  final ThemeRepository _themeRepository;

  AppBloc(this._intlRepository, this._themeRepository)
    : super(
        AppState(
          locale: Utils.getLocaleFromLanguageCode(
            _intlRepository.getCurrentLanguageCode(),
          ),
          themeMode: _themeRepository.getThemeMode(),
        ),
      ) {
    on<_ChangeLanguage>(_onChangeLanguage);
    on<_ChangeTheme>(_onChangeTheme);
  }

  // Function to change app language.
  void _onChangeLanguage(_ChangeLanguage event, Emitter<AppState> emit) {
    _intlRepository.setCurrentLanguageCode(event.languageCode);

    emit(
      state.copyWith(
        locale: Utils.getLocaleFromLanguageCode(event.languageCode),
      ),
    );
  }

  // Function to change app theme mode.
  void _onChangeTheme(_ChangeTheme event, Emitter<AppState> emit) {
    _themeRepository.setThemeMode(event.themeMode);

    emit(state.copyWith(themeMode: event.themeMode));
  }
}
