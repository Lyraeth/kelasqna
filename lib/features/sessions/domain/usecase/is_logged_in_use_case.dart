import 'package:kelasqna/kelasqna.dart';

class IsLoggedInUseCase {
  final SessionsRepository _sessionsRepository;

  IsLoggedInUseCase(this._sessionsRepository);

  Future<bool> call() => _sessionsRepository.isLoggedIn();
}
