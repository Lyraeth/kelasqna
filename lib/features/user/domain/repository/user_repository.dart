import 'package:kelasqna/kelasqna.dart';

abstract class UserRepository {
  Future<Result<RegisterResponse>> register(UserRegisterParams registerParams);
}
