import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String name,
    required String email,
    @JsonKey(name: "email_verified_at") DateTime? emailVerifiedAt,
    @JsonKey(name: "created_at") required DateTime createdAt,
    @JsonKey(name: "updated_at") required DateTime updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
