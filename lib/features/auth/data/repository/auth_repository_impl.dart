import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<LoginResponse>> login(LoginParams loginParams) async {
    final response = await _remoteDataSource.login(
      LoginRequest(
        email: loginParams.email,
        password: loginParams.password,
        deviceName: loginParams.deviceName,
      ),
    );

    return response.match((failure) => Left(failure), (
      LoginResponse authResponse,
    ) async {
      return Right(authResponse);
    });
  }

  @override
  Future<Unit> logout() async {
    await _remoteDataSource.logout();
    return unit;
  }
}
