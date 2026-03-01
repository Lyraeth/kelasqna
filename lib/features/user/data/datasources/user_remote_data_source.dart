import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

abstract class UserRemoteDataSource {
  Future<Result<RegisterResponse>> register(RegisterRequest registerRequest);
}

class UserRemoteDateSourceImpl implements UserRemoteDataSource {
  final ApiClient _apiClient;

  UserRemoteDateSourceImpl(this._apiClient);

  @override
  Future<Result<RegisterResponse>> register(
    RegisterRequest registerRequest,
  ) async {
    final body = registerRequest.toJson();

    debugPrint(body.toString());

    try {
      final response = await _apiClient.post(registerUrl, data: body);

      return response.fold(
        (failure) async => Left(failure),
        (jsonMap) async => ApiHelper.parseResponse(
          jsonMap,
          (json) => RegisterResponse.fromJson(json),
        ),
      );
    } catch (e) {
      return Left(Failure.fromDio(e));
    }
  }
}
