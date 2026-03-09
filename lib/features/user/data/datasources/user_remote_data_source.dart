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

    try {
      final response = await _apiClient.post(registerUrl, data: body);

      return response.match(
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
}
