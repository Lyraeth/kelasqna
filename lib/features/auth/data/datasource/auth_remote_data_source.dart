import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

abstract class AuthRemoteDataSource {
  Future<Result<LoginResponse>> login(LoginRequest loginRequest);

  Future<Unit> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<LoginResponse>> login(LoginRequest loginRequest) async {
    final body = loginRequest.toJson();

    debugPrint(body.toString());

    try {
      final response = await _apiClient.post(loginUrl, data: body);

      return response.fold(
        (failure) async => Left(failure),
        (jsonMap) async => ApiHelper.parseResponse(
          jsonMap,
          (json) => LoginResponse.fromJson(json),
        ),
      );
    } catch (e, st) {
      return Left(Failure.fromDio(e, st));
    }
  }

  @override
  Future<Unit> logout() async {
    try {
      await _apiClient.post(logoutUrl, data: {});

      await secureStorage.deleteAll();

      return unit;
    } catch (e) {
      return unit;
    }
  }

  // @override
  // Future<Result<RegisterResponse>> register(
  //   RegisterRequest registerRequest,
  // ) async {
  //   final body = registerRequest.toJson();
  //
  //   try {
  //     final response = await _apiClient.post(registerUrl, data: body);
  //
  //     return response.fold(
  //       (failure) async => Left(failure),
  //       (jsonMap) async => ApiHelper.parseResponse(
  //         jsonMap,
  //         (json) => RegisterResponse.fromJson(json),
  //       ),
  //     );
  //   } catch (e, st) {
  //     return Left(Failure.fromDio(e, st));
  //   }
  // }

  // @override
  // Future<Result<UserResponse>> fetchAndCacheMe() async {
  //   try {
  //     final response = await _apiClient.get(meUrl);
  //
  //     return response.fold(
  //       (failure) async => Left(failure),
  //       (jsonMap) async => ApiHelper.parseResponse(
  //         jsonMap,
  //         (json) => UserResponse.fromJson(json),
  //       ),
  //     );
  //   } catch (e, st) {
  //     return Left(Failure.fromDio(e, st));
  //   }
  // }
}
