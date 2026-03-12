import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class LikeQuestionUseCase {
  final QuestionsRepository _questionsRepository;

  LikeQuestionUseCase(this._questionsRepository);

  Future<Result<Unit>> call(int id) async =>
      await _questionsRepository.likeQuestion(id: id);
}
