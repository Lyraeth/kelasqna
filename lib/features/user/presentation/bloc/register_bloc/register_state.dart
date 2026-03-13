part of 'register_bloc.dart';

@freezed
abstract class RegisterState with _$RegisterState {
  const factory RegisterState.initial() = _Initial;

  const factory RegisterState.loading() = _Loading;

  const factory RegisterState.success({required UserEntity user}) = _Success;

  const factory RegisterState.failure(Failure failure) = _Failure;
}
