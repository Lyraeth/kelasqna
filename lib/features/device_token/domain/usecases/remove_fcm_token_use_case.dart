import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class RemoveFcmTokenUseCase {
  final DeviceTokenRepository _deviceTokenRepository;

  RemoveFcmTokenUseCase(this._deviceTokenRepository);

  Future<Result<Unit>> call({required String token}) async =>
      await _deviceTokenRepository.removeFcmToken(token: token);
}
