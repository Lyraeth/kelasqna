import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class ClearSessionUseCase {
  final SessionsRepository _sessionsRepository;

  ClearSessionUseCase(this._sessionsRepository);

  Future<Unit> call() => _sessionsRepository.clearSession();
}
