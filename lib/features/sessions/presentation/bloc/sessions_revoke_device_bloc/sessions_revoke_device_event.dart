part of 'sessions_revoke_device_bloc.dart';

@freezed
abstract class SessionsRevokeDeviceEvent with _$SessionsRevokeDeviceEvent {
  const factory SessionsRevokeDeviceEvent.revokeSession({required int id}) =
      _RevokeSession;
}
