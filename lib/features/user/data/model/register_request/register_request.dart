import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'register_request.freezed.dart';
part 'register_request.g.dart';

@freezed
abstract class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String name,
    required String email,
    required String password,
    @JsonKey(name: "password_confirmation")
    required String passwordConfirmation,
    UserRole? role,
    @JsonKey(name: "class_name") String? className,
    @JsonKey(name: "class_number") String? classNumber,
    String? subject,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}
