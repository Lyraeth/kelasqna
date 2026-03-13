import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class DeleteSessionDeviceUseCase {
  final SessionsRepository _sessionsRepository;

  DeleteSessionDeviceUseCase(this._sessionsRepository);

  Future<Result<Unit>> call(int sessionId) async =>
      await _sessionsRepository.deleteSessionDevice(sessionId);
}
