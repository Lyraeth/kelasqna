import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

abstract class AppLockRepository {
  Future<AppLockEntity> getAppLockSettings();

  Future<Unit> saveAppLockSettings(AppLockEntity appLockEntity);
}
