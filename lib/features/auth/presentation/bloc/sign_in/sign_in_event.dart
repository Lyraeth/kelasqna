part of 'sign_in_bloc.dart';

@freezed
abstract class SignInEvent with _$SignInEvent {
  const factory SignInEvent.started() = _Started;

  const factory SignInEvent.rememberMeChanged({
    required bool value,
    required String username,
  }) = _RememberMeChanged;

  const factory SignInEvent.login({
    required String username,
    required String password,
  }) = _Login;
}
