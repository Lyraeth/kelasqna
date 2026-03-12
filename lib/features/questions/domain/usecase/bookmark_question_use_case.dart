import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class BookmarkQuestionUseCase {
  final QuestionsRepository _questionsRepository;

  BookmarkQuestionUseCase(this._questionsRepository);

  Future<Result<Unit>> call(int id) async =>
      _questionsRepository.bookmarkQuestion(id: id);
}
