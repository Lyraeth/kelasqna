import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class SetFirstTimeUserOpenedAppUseCase {
  final SessionsRepository _sessionsRepository;

  SetFirstTimeUserOpenedAppUseCase(this._sessionsRepository);

  Future<Unit> call(bool value) =>
      _sessionsRepository.setFirstTimeUserOpenedApp(value);
}
