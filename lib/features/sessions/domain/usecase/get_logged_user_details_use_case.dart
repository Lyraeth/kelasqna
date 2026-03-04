import 'package:kelasqna/kelasqna.dart';

class GetLoggedUserDetailsUseCase {
  final SessionsRepository _sessionsRepository;

  GetLoggedUserDetailsUseCase(this._sessionsRepository);

  UserEntity? call() => _sessionsRepository.getLoggedUserDetails();
}
