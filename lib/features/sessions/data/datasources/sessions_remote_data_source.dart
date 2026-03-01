import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

abstract class SessionsRemoteDataSource {
  Future<Result<UserModel>> me();
}

class SessionsRemoteDataSourceImpl implements SessionsRemoteDataSource {
  final ApiClient _apiClient;

  SessionsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<UserModel>> me() async {
    try {
      final response = await _apiClient.get(meUrl);

      return response.fold(
        (failure) => Left(failure),
        (jsonMap) => Right(UserModel.fromJson(jsonMap)),
      );
    } catch (e) {
      return Left(Failure.fromDio(e));
    }
  }
}
