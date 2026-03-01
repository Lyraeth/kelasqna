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
  Future<Result<UserEntity>> me() async {
    final response = await _sessionsRemoteDataSource.me();

    return response.fold(
      (failure) => Left(failure),
      (UserModel userModel) => Right(userModel.toEntity()),
    );
  }

  @override
  Future<Unit> setAccessToken(String value) =>
      _sessionsLocalDataSource.setAccessToken(value);

  @override
  Future<Unit> clearSession() => _sessionsLocalDataSource.clearSession();

  @override
  Future<bool> isLoggedIn() async {
    final token = await _sessionsLocalDataSource.getAccessToken();

    return token != null && token.isNotEmpty;
  }

  @override
  Future<bool> isFirstTimeUserOpenApp() async =>
      _sessionsLocalDataSource.isFirstTimeUserOpenApp();

  @override
  Future<Unit> setFirstTimeUserOpenedApp(bool value) async =>
      _sessionsLocalDataSource.setIsFirstTimeUserOpenedApp(value);
}
