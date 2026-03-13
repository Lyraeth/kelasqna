part of 'sessions_revoke_device_bloc.dart';

@freezed
abstract class SessionsRevokeDeviceState with _$SessionsRevokeDeviceState {
  const factory SessionsRevokeDeviceState.initial() = _Initial;

  const factory SessionsRevokeDeviceState.loading() = _Loading;

  const factory SessionsRevokeDeviceState.success() = _Success;

  const factory SessionsRevokeDeviceState.failure(Failure failure) = _Failure;
}
