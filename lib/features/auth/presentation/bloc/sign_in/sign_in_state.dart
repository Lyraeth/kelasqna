part of 'sign_in_bloc.dart';

@freezed
abstract class SignInState with _$SignInState {
  const factory SignInState.initial({
    @Default(false) bool isRemembered,
    String? rememberedUsername,
  }) = _Initial;

  const factory SignInState.loading({
    required bool isRemembered,
    String? rememberedUsername,
  }) = _Loading;

  const factory SignInState.success() = _Success;

  const factory SignInState.failure({
    required String errorMessage,
    String? detailedErrorMessage,
  }) = _Failure;
}
