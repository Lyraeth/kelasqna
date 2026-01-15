part of 'app_bloc.dart';

@freezed
abstract class AppState with _$AppState {
  const factory AppState({
    // Language.
    required Locale locale,

    // Theme mode.
    required ThemeMode themeMode,
  }) = _AppState;
}
