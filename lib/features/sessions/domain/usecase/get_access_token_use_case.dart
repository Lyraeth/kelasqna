import 'package:kelasqna/kelasqna.dart';

class GetAccessTokenUseCase {
  final SessionsRepository _sessionsRepository;

  GetAccessTokenUseCase(this._sessionsRepository);

  Future<String?> call() => _sessionsRepository.getAccessToken();
}
