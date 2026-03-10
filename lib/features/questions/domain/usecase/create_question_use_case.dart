import 'package:kelasqna/kelasqna.dart';

class CreateQuestionUseCase {
  final QuestionsRepository _questionsRepository;

  CreateQuestionUseCase(this._questionsRepository);

  Future<Result<QuestionEntity>> call(QuestionParams questionParams) async =>
      await _questionsRepository.createQuestion(questionParams);
}
