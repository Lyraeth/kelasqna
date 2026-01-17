part of 'me_bloc.dart';

@freezed
abstract class MeState with _$MeState {
  const factory MeState.initial() = _Initial;

  const factory MeState.loading() = _Loading;

  const factory MeState.success({required UserResponse userResponse}) =
      _Success;

  const factory MeState.failure(String errorMessage) = _Failure;
}
