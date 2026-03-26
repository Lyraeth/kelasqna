import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class AppLockRepositoryImpl implements AppLockRepository {
  final AppLockLocalDataSource _appLockLocalDataSource;

  AppLockRepositoryImpl(this._appLockLocalDataSource);

  @override
  Future<AppLockEntity> getAppLockSettings() async {
    final response = await _appLockLocalDataSource.getAppLockSettings();

    return response.toEntity();
  }

  @override
  Future<Unit> saveAppLockSettings(AppLockEntity appLockEntity) async {
    await _appLockLocalDataSource.saveAppLockSettings(appLockEntity.toModel());

    return unit;
  }
}
