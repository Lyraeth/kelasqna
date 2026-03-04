import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SessionsLocalDataSource {
  Future<String?> getAccessToken();

  Future<Unit> saveAccessToken(String value);

  Future<Unit> clearSession();

  UserEntity? getLoggedUserDetails();

  Future<Unit> saveLoggedUserDetails(UserEntity userEntity);

  Future<bool> isFirstTimeUserOpenApp();

  Future<Unit> setIsFirstTimeUserOpenedApp(bool value);
}

class SessionsLocalDataSourceImpl implements SessionsLocalDataSource {
  final SharedPreferences prefs = sI<SharedPreferences>();

  @override
  Future<String?> getAccessToken() async =>
      await secureStorage.read(key: kAccessTokenKey);

  @override
  Future<Unit> saveAccessToken(String value) async {
    try {
      await secureStorage.write(key: kAccessTokenKey, value: value);
      debugPrint("Success to save accessToken");
    } catch (e) {
      debugPrint("Failed to save accessToken");
    }

    return unit;
  }

  @override
  Future<Unit> clearSession() async {
    await secureStorage.delete(key: kAccessTokenKey);
    debugPrint("await secureStorage.delete(key: kAccessTokenKey) success");

    await Hive.box(sessionsBoxKey).delete(sessionsUserDetailsKey);
    debugPrint(
      "await Hive.box(sessionsBoxKey).delete(sessionsUserDetailsKey) success",
    );

    await prefs.remove(kSessionIsFirstTimeUserOpenAppKey);
    debugPrint("await prefs.remove(kSessionIsFirstTimeUserOpenAppKey) success");

    return unit;
  }

  @override
  UserEntity? getLoggedUserDetails() {
    final raw = Hive.box(sessionsBoxKey).get(sessionsUserDetailsKey);

    if (raw == null) return null;

    return UserEntity.fromJson(Map<String, dynamic>.from(raw));
  }

  @override
  Future<Unit> saveLoggedUserDetails(UserEntity userEntity) async {
    await Hive.box(
      sessionsBoxKey,
    ).put(sessionsUserDetailsKey, userEntity.toJson());

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
