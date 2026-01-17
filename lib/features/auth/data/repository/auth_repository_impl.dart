import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/core/shared/types.dart';
import 'package:kelasqna/features/auth/data/datasource/auth_local_data_source.dart';
import 'package:kelasqna/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:kelasqna/features/auth/data/model/auth_response.dart';
import 'package:kelasqna/features/auth/data/model/register_response.dart';
import 'package:kelasqna/features/auth/data/model/user_model.dart';
import 'package:kelasqna/features/auth/data/model/user_response/user_response.dart';
import 'package:kelasqna/features/auth/domain/entity/user_entity.dart';
import 'package:kelasqna/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource;
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<String?> getJwtToken() => _localDataSource.getJwtToken();

  @override
  UserEntity? getUserDetails() => _localDataSource.getUserDetails()?.toEntity();

  @override
  Future<Result<AuthResponse>> login({
    required String username,
    required String password,
  }) async {
    final response = await _remoteDataSource.login(
      username: username,
      password: password,
    );

    return response.fold((failure) => Left(failure), (
      AuthResponse authResponse,
    ) async {
      await Future.wait([setJwtToken(authResponse.jwtToken)]);
      return Right(authResponse);
    });
  }

  @override
  Future<void> setJwtToken(String value) => _localDataSource.setJwtToken(value);

  @override
  Future<void> setUserDetails(UserEntity userEntity) =>
      _localDataSource.setUserDetails(userEntity.toModel());

  @override
  Future<Result<RegisterResponse>> registerUser({
    required String name,
    required String username,
    required String password,
  }) async {
    final response = await _remoteDataSource.registerUser(
      name: name,
      username: username,
      password: password,
    );

    return response.fold(
      (failure) => Left(failure),
      (RegisterResponse registerResponse) => Right(registerResponse),
    );
  }

  @override
  Future<Result<UserResponse>> me() async {
    final response = await _remoteDataSource.me();

    return response.fold((failure) => Left(failure), (
      UserResponse userResponse,
    ) async {
      await Future.wait([setUserDetails(userResponse.userModel.toEntity())]);

      return Right(userResponse);
    });
  }

  @override
  Future<String?> getUsernameFromRememberMe() =>
      _localDataSource.getUsernameFromRememberMe();

  @override
  Future<void> setUsernameFromRememberMe(String value) =>
      _localDataSource.setUsernameFromRememberMe(value);
}
