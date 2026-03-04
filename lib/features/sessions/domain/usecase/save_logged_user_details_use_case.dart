import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class SaveLoggedUserDetailsUseCase {
  final SessionsRepository _sessionsRepository;

  SaveLoggedUserDetailsUseCase(this._sessionsRepository);

  Future<Unit> call(UserEntity userEntity) async =>
      _sessionsRepository.saveLoggedUserDetails(userEntity);
}
