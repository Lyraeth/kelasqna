import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class DeleteQuestionUseCase {
  final QuestionsRepository _questionsRepository;

  DeleteQuestionUseCase(this._questionsRepository);

  Future<Unit> call({required int id}) async =>
      await _questionsRepository.deleteQuestion(id: id);
}
