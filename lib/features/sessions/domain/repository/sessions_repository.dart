import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

abstract class SessionsRepository {
  Future<Result<MeResponse>> me();

  Future<String?> getAccessToken();

  Future<Unit> saveAccessToken(String value);

  Future<Unit> clearSession();

  Future<bool> isLoggedIn();

  UserEntity? getLoggedUserDetails();

  Future<Unit> saveLoggedUserDetails(UserEntity userEntity);

  Future<bool> isFirstTimeUserOpenApp();

  Future<Unit> setFirstTimeUserOpenedApp(bool value);

  Future<Result<List<SessionsDeviceEntity>>> fetchSessionsDevice();

  Future<Result<Unit>> deleteSessionDevice(int sessionId);
}
