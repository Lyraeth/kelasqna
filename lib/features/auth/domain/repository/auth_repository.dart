import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

abstract class AuthRepository {
  Future<Result<LoginResponse>> login(LoginParams loginParams);

  Future<Unit> logout();
}
