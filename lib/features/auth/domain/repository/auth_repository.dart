import 'package:kelasqna/core/shared/types.dart';
import 'package:kelasqna/features/auth/data/model/auth_response.dart';
import 'package:kelasqna/features/auth/data/model/register_response.dart';
import 'package:kelasqna/features/auth/data/model/user_response/user_response.dart';
import 'package:kelasqna/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  UserEntity? getUserDetails();

  Future<void> setUserDetails(UserEntity userEntity);

  Future<String?> getJwtToken();

  Future<void> setJwtToken(String value);

  Future<String?> getUsernameFromRememberMe();

  Future<void> setUsernameFromRememberMe(String value);

  Future<Result<RegisterResponse>> registerUser({
    required String name,
    required String username,
    required String password,
  });

  Future<Result<AuthResponse>> login({
    required String username,
    required String password,
  });

  Future<Result<UserResponse>> me();
}
