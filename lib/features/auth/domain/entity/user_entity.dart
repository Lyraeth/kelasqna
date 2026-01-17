import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/core/shared/enum.dart';
import 'package:kelasqna/features/auth/data/model/user_model.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required int id,
    required String name,
    required String username,
    required UserRole role,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}

extension UserEntityToModel on UserEntity {
  UserModel toModel() {
    return UserModel(
      id: id,
      name: name,
      username: username,
      role: role,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  UserEntity fromModel(UserModel userModel) {
    return UserEntity(
      id: userModel.id,
      name: userModel.name,
      username: userModel.username,
      role: userModel.role,
      createdAt: userModel.createdAt,
      updatedAt: userModel.updatedAt,
    );
  }
}
