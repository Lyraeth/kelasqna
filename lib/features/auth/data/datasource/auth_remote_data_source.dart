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

      return response.match(
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

      return unit;
    } catch (e) {
      return unit;
    }
  }
}
