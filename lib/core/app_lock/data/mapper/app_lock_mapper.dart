import 'package:kelasqna/kelasqna.dart';

extension AppLockModelMapper on AppLockModel {
  AppLockEntity toEntity() =>
      AppLockEntity(isEnable: isEnable, lockAfterMinutes: lockAfterMinutes);
}

extension AppLockEntityMapper on AppLockEntity {
  AppLockModel toModel() =>
      AppLockModel(lockAfterMinutes: lockAfterMinutes, isEnable: isEnable);
}
