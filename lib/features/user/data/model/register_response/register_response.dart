import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'register_response.freezed.dart';
part 'register_response.g.dart';

@freezed
abstract class RegisterResponse with _$RegisterResponse {
  const factory RegisterResponse({
    required bool error,
    required String message,
    @JsonKey(name: "user") required UserModel userModel,
  }) = _RegisterResponse;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
}
