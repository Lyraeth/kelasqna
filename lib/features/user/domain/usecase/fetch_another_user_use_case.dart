import 'package:kelasqna/kelasqna.dart';

class FetchAnotherUserUseCase {
  final UserRepository _userRepository;

  FetchAnotherUserUseCase(this._userRepository);

  Future<Result<UserEntity>> call({required int id}) async =>
      await _userRepository.fetchAnotherUser(id: id);
}
