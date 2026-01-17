import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/core/internationalization/domain/usecase/intl_use_case.dart';
import 'package:kelasqna/core/theme/domain/usecase/theme_use_case.dart';
import 'package:kelasqna/utils/utils.dart';

part 'app_bloc.freezed.dart';
part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final IntlUseCase _intlUseCase;
  final ThemeUseCase _themeUseCase;

  AppBloc(this._intlUseCase, this._themeUseCase)
    : super(
        AppState(
          locale: Utils.getLocaleFromLanguageCode(
            _intlUseCase.getCurrentLanguageCode(),
          ),
          themeMode: _themeUseCase.getThemeMode(),
        ),
      ) {
    on<_ChangeLanguage>(_onChangeLanguage);
    on<_ChangeTheme>(_onChangeTheme);
  }

  // Function to change app language.
  void _onChangeLanguage(_ChangeLanguage event, Emitter<AppState> emit) {
    _intlUseCase.setCurrentLanguageCode(event.languageCode);

    emit(
      state.copyWith(
        locale: Utils.getLocaleFromLanguageCode(event.languageCode),
      ),
    );
  }

  // Function to change app theme mode.
  void _onChangeTheme(_ChangeTheme event, Emitter<AppState> emit) {
    _themeUseCase.setThemeMode(event.themeMode);

    emit(state.copyWith(themeMode: event.themeMode));
  }
}
