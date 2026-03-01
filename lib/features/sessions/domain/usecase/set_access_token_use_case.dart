import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class SetAccessTokenUseCase {
  final SessionsRepository _sessionsRepository;

  SetAccessTokenUseCase(this._sessionsRepository);

  Future<Unit> call(String value) => _sessionsRepository.setAccessToken(value);
}
