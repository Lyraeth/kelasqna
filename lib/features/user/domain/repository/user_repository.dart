import 'package:kelasqna/kelasqna.dart';

abstract class UserRepository {
  Future<Result<RegisterResponse>> register(UserRegisterParams registerParams);

  Future<Result<UserEntity>> fetchAnotherUser({required int id});
}
