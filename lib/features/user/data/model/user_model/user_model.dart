import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String name,
    required String email,
    required UserRole role,
    @JsonKey(name: "display_role") String? displayRole,
    String? avatar,
    @JsonKey(name: "class_name") String? className,
    @JsonKey(name: "class_number") String? classNumber,
    String? subject,
    @JsonKey(name: "created_at") required DateTime createdAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
