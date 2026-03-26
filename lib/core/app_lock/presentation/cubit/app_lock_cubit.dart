import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'app_lock_cubit.freezed.dart';
part 'app_lock_state.dart';

class AppLockCubit extends Cubit<AppLockState> {
  final GetAppLockSettingsUseCase _getAppLockSettingsUseCase;
  final SaveAppLockSettingsUseCase _saveAppLockSettingsUseCase;

  AppLockCubit(
    this._getAppLockSettingsUseCase,
    this._saveAppLockSettingsUseCase,
  ) : super(const AppLockState.initial()) {
    _init();
  }

  DateTime? _backgroundedAt;

  AppLockEntity _defaultSettings = const AppLockEntity(
    isEnable: false,
    lockAfterMinutes: 3,
  );

  AppLockEntity get currentSettings => _defaultSettings;

  Future<void> _init() async {
    final settings = await _getAppLockSettingsUseCase.call();

    _defaultSettings = settings;

    emit(AppLockState.settings(appLockEntity: settings));
  }

  void onAppBackground() {
    if (!_defaultSettings.isEnable) return;

    _backgroundedAt ??= DateTime.now();
    debugPrint("onAppBackground() → _backgroundedAt = $_backgroundedAt");
  }

  void onAppForeground() {
    debugPrint("onAppForeground()");

    if (!_defaultSettings.isEnable) return;

    final backgroundedAt = _backgroundedAt;
    _backgroundedAt = null;
    if (backgroundedAt == null) return;

    final elapsed = DateTime.now().difference(backgroundedAt);
    debugPrint("Elapsed: $elapsed");
    final lockDuration = Duration(minutes: _defaultSettings.lockAfterMinutes);
    debugPrint("LockDuration: $lockDuration");

    if (elapsed >= lockDuration) {
      emit(const AppLockState.locked());
    }
  }

  Future<void> updateSettings(AppLockEntity appLockEntity) async {
    _defaultSettings = appLockEntity;

    await _saveAppLockSettingsUseCase.call(appLockEntity);

    emit(AppLockState.settings(appLockEntity: appLockEntity));
  }

  void unlock() => emit(const AppLockState.unlocked());

  void lock() => emit(const AppLockState.locked());
}
