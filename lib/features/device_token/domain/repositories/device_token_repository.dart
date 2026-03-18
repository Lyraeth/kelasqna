import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

abstract class DeviceTokenRepository {
  Future<Result<Unit>> registerFcmToken({
    required String token,
    required String deviceType,
  });

  Future<Result<Unit>> removeFcmToken({required String token});
}
