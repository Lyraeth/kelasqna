import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

abstract class QuestionsRepository {
  Future<Result<List<QuestionEntity>>> fetchAllQuestion();

  Future<Result<QuestionEntity>> fetchQuestion({required int id});

  Future<Result<QuestionEntity>> createQuestion(QuestionParams questionParams);

  Future<Result<QuestionEntity>> editQuestion(
    int id, {
    EditQuestionParams? editQuestionParams,
  });

  Future<Unit> deleteQuestion({required int id});
}
