import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'app_bloc.freezed.dart';
part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final ThemeUseCase _themeUseCase;
  final LanguageStorage _languageStorage;

  AppBloc(this._themeUseCase, this._languageStorage)
    : super(
        AppState(
          locale: const Locale('en'),
          themeMode: _themeUseCase.getThemeMode(),
        ),
      ) {
    on<_ChangeLanguage>(_onChangeLanguage);
    on<_ChangeTheme>(_onChangeTheme);
    on<_LoadInitialLanguage>(_onLoadInitialLanguage);

    add(const AppEvent.loadInitialLanguage());
  }

  Future<void> _onLoadInitialLanguage(
    _LoadInitialLanguage event,
    Emitter<AppState> emit,
  ) async {
    final savedCode = await _languageStorage.get();

    if (savedCode != null) {
      emit(state.copyWith(locale: Locale(savedCode)));
    }
  }

  void _onChangeLanguage(_ChangeLanguage event, Emitter<AppState> emit) async {
    await _languageStorage.save(event.languageCode);

    emit(state.copyWith(locale: Locale(event.languageCode)));
  }

  void _onChangeTheme(_ChangeTheme event, Emitter<AppState> emit) {
    _themeUseCase.setThemeMode(event.themeMode);

    emit(state.copyWith(themeMode: event.themeMode));
  }

  String get languageCode => state.locale.languageCode;

  String get themeMode => state.themeMode.name;
}
