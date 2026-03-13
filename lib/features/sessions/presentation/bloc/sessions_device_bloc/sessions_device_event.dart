part of 'sessions_device_bloc.dart';

@freezed
abstract class SessionsDeviceEvent with _$SessionsDeviceEvent {
  const factory SessionsDeviceEvent.started({
    @Default(false) bool forceRefresh,
  }) = _Started;
}
