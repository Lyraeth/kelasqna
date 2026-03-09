import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'user_register_params.freezed.dart';

@freezed
abstract class UserRegisterParams with _$UserRegisterParams {
  const factory UserRegisterParams({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    UserRole? role,
    String? className,
    String? classNumber,
    String? subject,
  }) = _UserRegisterParams;
}
