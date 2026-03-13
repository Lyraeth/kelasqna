import 'package:kelasqna/kelasqna.dart';

extension UserModelMapper on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      avatar: avatar,
      className: className,
      classNumber: classNumber,
      displayRole: displayRole,
      subject: subject,
      role: role,
      createdAt: createdAt,
    );
  }
}

extension UserEntityMapper on UserEntity {
  UserModel toModel() {
    return UserModel(
      id: id,
      name: name,
      email: email,
      subject: subject,
      displayRole: displayRole,
      classNumber: classNumber,
      className: className,
      avatar: avatar,
      role: role,
      createdAt: createdAt,
    );
  }
}
