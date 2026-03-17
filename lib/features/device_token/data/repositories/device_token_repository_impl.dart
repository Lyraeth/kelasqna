import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class DeviceTokenRepositoryImpl implements DeviceTokenRepository {
  final DeviceTokenRemoteDataSource _remoteDataSource;

  DeviceTokenRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<Unit>> registerFcmToken({
    required String token,
    required String deviceType,
  }) async {
    final response = await _remoteDataSource.registerFcmToken(
      token: token,
      deviceType: deviceType,
    );

    return response.match((failure) => Left(failure), (res) => Right(unit));
  }

  @override
  Future<Result<Unit>> removeFcmToken({required String token}) async {
    final response = await _remoteDataSource.removeFcmToken(token: token);

    return response.match((failure) => Left(failure), (res) => Right(unit));
  }
}
