import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/core/shared/enum.dart';
import 'package:kelasqna/features/auth/domain/entity/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(name: "ID") required int id,
    @JsonKey(name: "Name") required String name,
    @JsonKey(name: "Username") required String username,
    @JsonKey(name: "Role") required UserRole role,
    @JsonKey(name: "CreatedAt") required DateTime createdAt,
    @JsonKey(name: "UpdatedAt") required DateTime updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  static Map<String, dynamic> empty() => {
    "ID": 0,
    "Name": "-",
    "Username": "-",
    "Role": UserRole.user.name.toString(),
    "CreatedAt": DateTime.now().toIso8601String(),
    "UpdatedAt": DateTime.now().toIso8601String(),
  };
}

extension UserModelToEntity on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      username: username,
      role: role,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  UserModel fromEntity(UserEntity userEntity) {
    return UserModel(
      id: userEntity.id,
      name: userEntity.name,
      username: userEntity.username,
      role: userEntity.role,
      createdAt: userEntity.createdAt,
      updatedAt: userEntity.updatedAt,
    );
  }
}
