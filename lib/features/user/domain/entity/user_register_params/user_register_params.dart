import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_register_params.freezed.dart';

@freezed
abstract class UserRegisterParams with _$UserRegisterParams {
  const factory UserRegisterParams({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) = _UserRegisterParams;
}
