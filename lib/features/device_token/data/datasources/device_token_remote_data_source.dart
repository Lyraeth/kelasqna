import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

abstract class DeviceTokenRemoteDataSource {
  Future<Result<Unit>> registerFcmToken({
    required String token,
    required String deviceType,
  });

  Future<Result<Unit>> removeFcmToken({required String token});
}

class DeviceTokenRemoteDataSourceImpl implements DeviceTokenRemoteDataSource {
  final ApiClient _apiClient;

  DeviceTokenRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<Unit>> registerFcmToken({
    required String token,
    required String deviceType,
  }) async {
    final Map<String, dynamic> data = {
      'token': token,
      'device_type': deviceType,
    };

    try {
      final response = await _apiClient.post(deviceTokenUrl, data: data);

      return response.match((failure) => Left(failure), (json) => Right(unit));
    } catch (e, st) {
      return Left(Failure.fromDio(e, st));
    }
  }

  @override
  Future<Result<Unit>> removeFcmToken({required String token}) async {
    final Map<String, dynamic> data = {'token': token};

    try {
      final response = await _apiClient.delete(deviceTokenUrl, data: data);

      return response.match((failure) => Left(failure), (json) => Right(unit));
    } catch (e, st) {
      return Left(Failure.fromDio(e, st));
    }
  }
}
