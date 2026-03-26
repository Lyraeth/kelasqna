import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class SaveAppLockSettingsUseCase {
  final AppLockRepository _appLockRepository;

  SaveAppLockSettingsUseCase(this._appLockRepository);

  Future<Unit> call(AppLockEntity appLockEntity) async =>
      await _appLockRepository.saveAppLockSettings(appLockEntity);
}
