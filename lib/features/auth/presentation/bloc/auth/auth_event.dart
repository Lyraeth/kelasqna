part of 'auth_bloc.dart';

@freezed
abstract class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = _Started;

  const factory AuthEvent.authenticateUser() = _AuthenticatedUser;

  const factory AuthEvent.logout() = _Logout;
}
