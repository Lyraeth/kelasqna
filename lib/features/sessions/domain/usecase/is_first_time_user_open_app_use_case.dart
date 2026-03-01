import 'package:kelasqna/kelasqna.dart';

class IsFirstTimeUserOpenAppUseCase {
  final SessionsRepository _sessionsRepository;

  IsFirstTimeUserOpenAppUseCase(this._sessionsRepository);

  Future<bool> call() => _sessionsRepository.isFirstTimeUserOpenApp();
}
