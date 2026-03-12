import 'package:kelasqna/kelasqna.dart';

class FetchBookmarkedUserQuestionUseCase {
  final ProfileRepository _profileRepository;

  FetchBookmarkedUserQuestionUseCase(this._profileRepository);

  Future<Result<PaginatedResult<QuestionEntity>>> call({int page = 1}) async =>
      await _profileRepository.fetchBookmarkedUserQuestion(page: page);
}
