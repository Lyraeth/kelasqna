import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class LogoutUseCase {
  final AuthRepository _authRepository;

  LogoutUseCase(this._authRepository);

  Future<Unit> call() async => _authRepository.logout();
}
