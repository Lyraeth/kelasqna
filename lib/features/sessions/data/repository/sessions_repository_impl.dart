import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class SessionsRepositoryImpl implements SessionsRepository {
  final SessionsRemoteDataSource _sessionsRemoteDataSource;
  final SessionsLocalDataSource _sessionsLocalDataSource;

  SessionsRepositoryImpl(
    this._sessionsLocalDataSource,
    this._sessionsRemoteDataSource,
  );

  @override
  Future<String?> getAccessToken() async =>
      await _sessionsLocalDataSource.getAccessToken();

  @override
  Future<Result<MeResponse>> me() async {
    final response = await _sessionsRemoteDataSource.me();

    return response.fold(
      (failure) => Left(failure),
      (MeResponse meResponse) => Right(meResponse),
    );
  }

  @override
  Future<Unit> saveAccessToken(String value) =>
      _sessionsLocalDataSource.saveAccessToken(value);

  @override
  Future<Unit> clearSession() => _sessionsLocalDataSource.clearSession();

  @override
  Future<bool> isLoggedIn() async {
    final token = await _sessionsLocalDataSource.getAccessToken();

    return token != null && token.isNotEmpty;
  }

  @override
  UserEntity? getLoggedUserDetails() =>
      _sessionsLocalDataSource.getLoggedUserDetails();

  @override
  Future<Unit> saveLoggedUserDetails(UserEntity userEntity) async =>
      await _sessionsLocalDataSource.saveLoggedUserDetails(userEntity);

  @override
  Future<bool> isFirstTimeUserOpenApp() async =>
      _sessionsLocalDataSource.isFirstTimeUserOpenApp();

  @override
  Future<Unit> setFirstTimeUserOpenedApp(bool value) async =>
      _sessionsLocalDataSource.setIsFirstTimeUserOpenedApp(value);

  @override
  Future<Result<Unit>> deleteSessionDevice(int sessionId) async {
    final response = await _sessionsRemoteDataSource.deleteSessionDevice(
      sessionId,
    );

    return response.match(
      (failure) => Left(failure),
      (response) => Right(unit),
    );
  }

  @override
  Future<Result<List<SessionsDeviceEntity>>> fetchSessionsDevice() async {
    final response = await _sessionsRemoteDataSource.fetchSessionsDevice();

    return response.match(
      (failure) => Left(failure),
      (SessionsDeviceResponse sessionsDeviceResponse) => Right(
        sessionsDeviceResponse.listSessionsDevice
            .map((m) => m.toEntity())
            .toList(),
      ),
    );
  }
}
