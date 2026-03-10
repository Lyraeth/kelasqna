import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class QuestionsRepositoryImpl implements QuestionsRepository {
  final QuestionsRemoteDataSource _remoteDataSource;

  QuestionsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<QuestionEntity>>> fetchAllQuestion() async {
    final response = await _remoteDataSource.fetchAllQuestion();

    return response.match(
      (failure) => Left(failure),
      (QuestionsResponse questionsResponse) => Right(
        questionsResponse.listQuestion.map((m) => m.toEntity()).toList(),
      ),
    );
  }

  @override
  Future<Result<QuestionEntity>> fetchQuestion({required int id}) async {
    final response = await _remoteDataSource.fetchQuestion(id: id);

    return response.match(
      (failure) => Left(failure),
      (OneQuestionsResponse oneQuestionsResponse) =>
          Right(oneQuestionsResponse.question.toEntity()),
    );
  }

  @override
  Future<Result<QuestionEntity>> createQuestion(
    QuestionParams questionParams,
  ) async {
    final response = await _remoteDataSource.createQuestion(
      questionParams.toRequest(),
    );

    return response.match(
      (failure) => Left(failure),
      (OneQuestionsResponse oneQuestionsResponse) =>
          Right(oneQuestionsResponse.question.toEntity()),
    );
  }

  @override
  Future<Unit> deleteQuestion({required int id}) async {
    await _remoteDataSource.deleteQuestion(id: id);

    return unit;
  }

  @override
  Future<Result<QuestionEntity>> editQuestion(
    int id, {
    EditQuestionParams? editQuestionParams,
  }) async {
    final response = await _remoteDataSource.editQuestion(
      id,
      editQuestionRequest: editQuestionParams?.toRequest(),
    );

    return response.match(
      (failure) => Left(failure),
      (OneQuestionsResponse oneQuestionsResponse) =>
          Right(oneQuestionsResponse.question.toEntity()),
    );
  }
}
