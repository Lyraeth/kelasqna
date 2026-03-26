import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';
import 'package:kelasqna/kelasqna.dart';

abstract class AppLockLocalDataSource {
  Future<AppLockModel> getAppLockSettings();

  Future<Unit> saveAppLockSettings(AppLockModel appLockModel);
}

class AppLockLocalDataSourceImpl implements AppLockLocalDataSource {
  @override
  Future<AppLockModel> getAppLockSettings() async {
    final isEnable = Hive.box(
      settingsBoxKey,
    ).get(settingsAppLockIsEnableKey, defaultValue: false);

    final lockAfterMinutes = Hive.box(
      settingsBoxKey,
    ).get(settingsAppLockLockAfterMinutesKey, defaultValue: 3);

    return AppLockModel(isEnable: isEnable, lockAfterMinutes: lockAfterMinutes);
  }

  @override
  Future<Unit> saveAppLockSettings(AppLockModel appLockModel) async {
    await Hive.box(
      settingsBoxKey,
    ).put(settingsAppLockIsEnableKey, appLockModel.isEnable);
    await Hive.box(
      settingsBoxKey,
    ).put(settingsAppLockLockAfterMinutesKey, appLockModel.lockAfterMinutes);

    return unit;
  }
}
