import 'package:kelasqna/kelasqna.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<Result<LoginResponse>> call(LoginParams loginParams) =>
      _authRepository.login(loginParams);
}
