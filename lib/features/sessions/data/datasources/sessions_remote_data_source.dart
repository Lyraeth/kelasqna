import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

abstract class SessionsRemoteDataSource {
  Future<Result<MeResponse>> me();
}

class SessionsRemoteDataSourceImpl implements SessionsRemoteDataSource {
  final ApiClient _apiClient;

  SessionsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<MeResponse>> me() async {
    try {
      final response = await _apiClient.get(meUrl);

      return response.match(
        (failure) => Left(failure),
        (jsonMap) => Right(MeResponse.fromJson(jsonMap)),
      );
    } catch (e) {
      return Left(Failure.fromDio(e));
    }
  }
}
