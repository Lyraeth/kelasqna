import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class RegisterFcmTokenUseCase {
  final DeviceTokenRepository _deviceTokenRepository;

  RegisterFcmTokenUseCase(this._deviceTokenRepository);

  Future<Result<Unit>> call({
    required String token,
    required String deviceType,
  }) async => await _deviceTokenRepository.registerFcmToken(
    token: token,
    deviceType: deviceType,
  );
}
