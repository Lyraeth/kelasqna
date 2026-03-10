import 'package:kelasqna/kelasqna.dart';

class FetchAllQuestionsUseCase {
  final QuestionsRepository _questionsRepository;

  FetchAllQuestionsUseCase(this._questionsRepository);

  Future<Result<List<QuestionEntity>>> call() async =>
      await _questionsRepository.fetchAllQuestion();
}
