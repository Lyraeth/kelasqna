part of 'sessions_device_bloc.dart';

@freezed
abstract class SessionsDeviceState with _$SessionsDeviceState {
  const factory SessionsDeviceState.initial() = _Initial;

  const factory SessionsDeviceState.loading() = _Loading;

  const factory SessionsDeviceState.success({
    required List<SessionsDeviceEntity> listSessionDevice,
  }) = _Success;

  const factory SessionsDeviceState.failure(Failure failure) = _Failure;
}
