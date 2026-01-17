import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/features/auth/data/model/user_model.dart';

part 'user_response.freezed.dart';
part 'user_response.g.dart';

@freezed
abstract class UserResponse with _$UserResponse {
  const factory UserResponse({
    required bool error,
    required String message,
    @JsonKey(name: "data") required UserModel userModel,
  }) = _UserResponse;

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}
