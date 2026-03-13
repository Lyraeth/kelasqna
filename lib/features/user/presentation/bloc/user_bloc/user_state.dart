part of 'user_bloc.dart';

@freezed
abstract class UserState with _$UserState {
  const factory UserState.initial() = _Initial;

  const factory UserState.loading() = _Loading;

  const factory UserState.success({required UserEntity userEntity}) = _Success;

  const factory UserState.failure(Failure failure) = _Failure;
}
