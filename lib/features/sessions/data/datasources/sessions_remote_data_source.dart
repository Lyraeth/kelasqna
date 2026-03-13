import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

abstract class SessionsRemoteDataSource {
  Future<Result<MeResponse>> me();

  Future<Result<SessionsDeviceResponse>> fetchSessionsDevice();

  Future<Result<Unit>> deleteSessionDevice(int sessionId);
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

  @override
  Future<Result<Unit>> deleteSessionDevice(int sessionId) async {
    try {
      final response = await _apiClient.delete(
        sessionsUrl,
        body: {"token_id": sessionId},
      );

      return response.match((failure) => Left(failure), (r) => Right(unit));
    } catch (e, st) {
      return Left(Failure.fromDio(e, st));
    }
  }

  @override
  Future<Result<SessionsDeviceResponse>> fetchSessionsDevice() async {
    try {
      final response = await _apiClient.get(sessionsUrl);

      return response.match(
        (failure) => Left(failure),
        (jsonMap) => Right(SessionsDeviceResponse.fromJson(jsonMap)),
      );
    } catch (e, st) {
      return Left(Failure.fromDio(e, st));
    }
  }
}
