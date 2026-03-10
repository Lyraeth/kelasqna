import 'package:kelasqna/kelasqna.dart';

class EditQuestionUseCase {
  final QuestionsRepository _questionsRepository;

  EditQuestionUseCase(this._questionsRepository);

  Future<Result<QuestionEntity>> call(
    int id, {
    EditQuestionParams? editQuestionParams,
  }) async => await _questionsRepository.editQuestion(
    id,
    editQuestionParams: editQuestionParams,
  );
}
