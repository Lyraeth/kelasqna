part of 'app_lock_cubit.dart';

@freezed
abstract class AppLockState with _$AppLockState {
  const factory AppLockState.initial() = _Initial;

  const factory AppLockState.locked() = _Locked;

  const factory AppLockState.unlocked() = _Unlocked;

  const factory AppLockState.settings({required AppLockEntity appLockEntity}) =
      _Settings;
}
