import 'package:kelasqna/kelasqna.dart';

class MeUseCase {
  final SessionsRepository _sessionsRepository;

  MeUseCase(this._sessionsRepository);

  Future<Result<MeResponse>> call() async => _sessionsRepository.me();
}
