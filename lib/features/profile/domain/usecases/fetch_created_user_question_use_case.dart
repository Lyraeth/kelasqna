import 'package:kelasqna/kelasqna.dart';

class FetchCreatedUserQuestionUseCase {
  final ProfileRepository _profileRepository;

  FetchCreatedUserQuestionUseCase(this._profileRepository);

  Future<Result<PaginatedResult<QuestionEntity>>> call({
    int? userId,
    int page = 1,
  }) async => await _profileRepository.fetchCreatedUserQuestion(
    userId: userId,
    page: page,
  );
}
