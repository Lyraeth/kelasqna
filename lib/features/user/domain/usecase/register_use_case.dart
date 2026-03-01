import 'package:kelasqna/kelasqna.dart';

class RegisterUseCase {
  final UserRepository _userRepository;

  RegisterUseCase(this._userRepository);

  Future<Result<RegisterResponse>> call(
    UserRegisterParams registerParams,
  ) async => _userRepository.register(registerParams);
}
