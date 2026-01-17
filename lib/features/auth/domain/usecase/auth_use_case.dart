import 'package:kelasqna/core/shared/types.dart';
import 'package:kelasqna/features/auth/data/model/auth_response.dart';
import 'package:kelasqna/features/auth/data/model/register_response.dart';
import 'package:kelasqna/features/auth/data/model/user_response/user_response.dart';
import 'package:kelasqna/features/auth/domain/entity/user_entity.dart';
import 'package:kelasqna/features/auth/domain/repository/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  UserEntity? get getUserDetails => _authRepository.getUserDetails();

  Future<void> setUserDetails(UserEntity userEntity) =>
      _authRepository.setUserDetails(userEntity);

  Future<String?> get getJwtToken => _authRepository.getJwtToken();

  Future<void> setJwtToken(String value) => _authRepository.setJwtToken(value);

  Future<String?> getUsernameFromRememberMe() =>
      _authRepository.getUsernameFromRememberMe();

  Future<void> setUsernameFromRememberMe(String value) =>
      _authRepository.setUsernameFromRememberMe(value);

  Future<Result<RegisterResponse>> registerUser({
    required String name,
    required String username,
    required String password,
  }) async => _authRepository.registerUser(
    name: name,
    username: username,
    password: password,
  );

  Future<Result<AuthResponse>> login({
    required String username,
    required String password,
  }) async => _authRepository.login(username: username, password: password);

  Future<Result<UserResponse>> me() async => _authRepository.me();
}
