import 'package:kelasqna/kelasqna.dart';

class FetchCommentedUserQuestionUseCase {
  final ProfileRepository _profileRepository;

  FetchCommentedUserQuestionUseCase(this._profileRepository);

  Future<Result<PaginatedResult<CommentsEntity>>> call({int page = 1}) async =>
      await _profileRepository.fetchCommentedUserQuestion(page: page);
}
