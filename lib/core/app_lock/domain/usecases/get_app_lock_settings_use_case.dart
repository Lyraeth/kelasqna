import 'package:kelasqna/kelasqna.dart';

class GetAppLockSettingsUseCase {
  final AppLockRepository _appLockRepository;

  GetAppLockSettingsUseCase(this._appLockRepository);

  Future<AppLockEntity> call() async =>
      await _appLockRepository.getAppLockSettings();
}
