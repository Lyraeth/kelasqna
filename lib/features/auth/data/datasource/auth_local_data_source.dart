import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:kelasqna/core/storage/hive/hive_storage_label.dart';
import 'package:kelasqna/core/storage/secure_storage/secure_storage_label.dart';
import 'package:kelasqna/features/auth/data/model/user_model.dart';

abstract class AuthLocalDataSource {
  UserModel? getUserDetails();

  Future<void> setUserDetails(UserModel userModel);

  Future<String?> getJwtToken();

  Future<void> setJwtToken(String value);

  Future<String?> getUsernameFromRememberMe();

  Future<void> setUsernameFromRememberMe(String value);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(),
  );

  @override
  Future<String?> getJwtToken() async =>
      await _secureStorage.read(key: kJwtTokenKey);

  @override
  UserModel? getUserDetails() => UserModel.fromJson(
    Hive.box(authBoxKey).get(authDetailsUserKey) ?? UserModel.empty(),
  );

  @override
  Future<void> setJwtToken(String value) async =>
      _secureStorage.write(key: kJwtTokenKey, value: value);

  @override
  Future<void> setUserDetails(UserModel userModel) async =>
      Hive.box(authBoxKey).put(authDetailsUserKey, userModel.toJson());

  @override
  Future<String?> getUsernameFromRememberMe() async =>
      await _secureStorage.read(key: kUsernameFromRememberMeKey);

  @override
  Future<void> setUsernameFromRememberMe(String value) async =>
      _secureStorage.write(key: kUsernameFromRememberMeKey, value: value);
}
