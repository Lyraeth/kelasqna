import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_lock_cubit.freezed.dart';
part 'app_lock_state.dart';

const _kLockDuration = Duration(seconds: 15);

class AppLockCubit extends Cubit<AppLockState> {
  AppLockCubit() : super(const AppLockState.initial());

  DateTime? _backgroundedAt;

  void onAppBackground() {
    _backgroundedAt ??= DateTime.now();
    debugPrint("onAppBackground() → _backgroundedAt = $_backgroundedAt");
  }

  void onAppForeground() {
    debugPrint("onAppForeground()");
    final backgroundedAt = _backgroundedAt;
    _backgroundedAt = null;
    if (backgroundedAt == null) return;

    final elapsed = DateTime.now().difference(backgroundedAt);
    debugPrint("Elapsed: $elapsed");

    if (elapsed >= _kLockDuration) {
      emit(const AppLockState.locked());
    }
  }

  void unlock() => emit(const AppLockState.unlocked());

  void lock() => emit(const AppLockState.locked());
}
