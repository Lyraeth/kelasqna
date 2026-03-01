import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

abstract class SessionsRepository {
  Future<Result<UserEntity>> me();

  Future<String?> getAccessToken();

  Future<Unit> setAccessToken(String value);

  Future<Unit> clearSession();

  Future<bool> isLoggedIn();

  Future<bool> isFirstTimeUserOpenApp();

  Future<Unit> setFirstTimeUserOpenedApp(bool value);
}
