import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SessionsLocalDataSource {
  Future<String?> getAccessToken();

  Future<Unit> setAccessToken(String value);

  Future<Unit> clearSession();

  Future<bool> isFirstTimeUserOpenApp();

  Future<Unit> setIsFirstTimeUserOpenedApp(bool value);
}

class SessionsLocalDataSourceImpl implements SessionsLocalDataSource {
  final SharedPreferences prefs = sI<SharedPreferences>();

  @override
  Future<String?> getAccessToken() async =>
      await secureStorage.read(key: kAccessTokenKey);

  @override
  Future<Unit> setAccessToken(String value) async {
    await secureStorage.write(key: kAccessTokenKey, value: value);

    return unit;
  }

  @override
  Future<Unit> clearSession() async {
    await secureStorage.delete(key: kAccessTokenKey);

    return unit;
  }

  @override
  Future<bool> isFirstTimeUserOpenApp() async {
    return prefs.getBool(kSessionIsFirstTimeUserOpenAppKey) ?? true;
  }

  @override
  Future<Unit> setIsFirstTimeUserOpenedApp(bool value) async {
    await prefs.setBool(kSessionIsFirstTimeUserOpenAppKey, value);

    return unit;
  }
}
