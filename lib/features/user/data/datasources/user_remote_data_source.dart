import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

abstract class UserRemoteDataSource {
  Future<Result<RegisterResponse>> register(RegisterRequest registerRequest);

  Future<Result<UserResponse>> fetchAnotherUser({required int id});
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

  @override
  Future<Result<UserResponse>> fetchAnotherUser({required int id}) async {
    try {
      final response = await _apiClient.get("$userUrl/$id");

      return response.match(
        (failure) => Left(failure),
        (json) => Right(UserResponse.fromJson(json)),
      );
    } catch (e, st) {
      return Left(Failure.fromDio(e, st));
    }
  }
}
