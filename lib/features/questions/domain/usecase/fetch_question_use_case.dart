import 'package:kelasqna/kelasqna.dart';

class FetchQuestionUseCase {
  final QuestionsRepository _questionsRepository;

  FetchQuestionUseCase(this._questionsRepository);

  Future<Result<QuestionEntity>> call({required int id}) async =>
      await _questionsRepository.fetchQuestion(id: id);
}
