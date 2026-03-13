import 'package:kelasqna/kelasqna.dart';

class FetchAllQuestionsUseCase {
  final QuestionsRepository _questionsRepository;

  FetchAllQuestionsUseCase(this._questionsRepository);

  Future<Result<PaginatedResult<QuestionEntity>>> call({int page = 1}) async =>
      await _questionsRepository.fetchAllQuestion(page: page);
}
