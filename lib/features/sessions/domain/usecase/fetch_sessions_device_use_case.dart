import 'package:kelasqna/kelasqna.dart';

class FetchSessionsDeviceUseCase {
  final SessionsRepository _sessionsRepository;

  FetchSessionsDeviceUseCase(this._sessionsRepository);

  Future<Result<List<SessionsDeviceEntity>>> call() async =>
      await _sessionsRepository.fetchSessionsDevice();
}
