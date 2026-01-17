import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/core/api/api_client.dart';
import 'package:kelasqna/core/api/api_constant.dart';
import 'package:kelasqna/core/api/failures/failure.dart';
import 'package:kelasqna/core/shared/types.dart';
import 'package:kelasqna/features/auth/data/model/auth_response.dart';
import 'package:kelasqna/features/auth/data/model/register_response.dart';
import 'package:kelasqna/features/auth/data/model/user_response/user_response.dart';

abstract class AuthRemoteDataSource {
  Future<Result<AuthResponse>> login({
    required String username,
    required String password,
  });

  Future<Result<RegisterResponse>> registerUser({
    required String name,
    required String username,
    required String password,
  });

  Future<Result<UserResponse>> me();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<AuthResponse>> login({
    required String username,
    required String password,
  }) async {
    final Map<String, dynamic> body = {
      "username": username,
      "password": password,
    };
    try {
      final response = await _apiClient.post(loginUrl, data: body);

      return response.fold(
        (failure) async => Left(failure),
        (jsonMap) async => ApiHelper.parseResponse(
          jsonMap,
          (json) => AuthResponse.fromJson(json),
        ),
      );
    } catch (e, st) {
      return Left(Failure.fromDio(e, st));
    }
  }

  @override
  Future<Result<RegisterResponse>> registerUser({
    required String name,
    required String username,
    required String password,
  }) async {
    final Map<String, dynamic> body = {
      "Name": name,
      "Username": username,
      "Password": password,
    };

    try {
      final response = await _apiClient.post(registerUrl, data: body);

      return response.fold(
        (failure) async => Left(failure),
        (jsonMap) async => ApiHelper.parseResponse(
          jsonMap,
          (json) => RegisterResponse.fromJson(json),
        ),
      );
    } catch (e, st) {
      return Left(Failure.fromDio(e, st));
    }
  }

  @override
  Future<Result<UserResponse>> me() async {
    try {
      final response = await _apiClient.get(meUrl);

      return response.fold(
        (failure) async => Left(failure),
        (jsonMap) async => ApiHelper.parseResponse(
          jsonMap,
          (json) => UserResponse.fromJson(json),
        ),
      );
    } catch (e, st) {
      return Left(Failure.fromDio(e, st));
    }
  }
}
