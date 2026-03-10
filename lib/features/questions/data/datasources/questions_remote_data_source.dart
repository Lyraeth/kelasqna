import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

abstract class QuestionsRemoteDataSource {
  Future<Result<QuestionsResponse>> fetchAllQuestion();

  Future<Result<OneQuestionsResponse>> fetchQuestion({required int id});

  Future<Result<OneQuestionsResponse>> createQuestion(
    QuestionRequest questionRequest,
  );

  Future<Result<OneQuestionsResponse>> editQuestion(
    int id, {
    EditQuestionRequest? editQuestionRequest,
  });

  Future<Unit> deleteQuestion({required int id});
}

class QuestionsRemoteDataSourceImpl implements QuestionsRemoteDataSource {
  final ApiClient _apiClient;

  QuestionsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<QuestionsResponse>> fetchAllQuestion() async {
    try {
      final response = await _apiClient.get(questionsUrl);

      return response.match(
        (failure) => Left(failure),
        (questionsResponse) =>
            Right(QuestionsResponse.fromJson(questionsResponse)),
      );
    } catch (e, st) {
      return Left(Failure.fromDio(e, st));
    }
  }

  @override
  Future<Result<OneQuestionsResponse>> fetchQuestion({required int id}) async {
    try {
      final response = await _apiClient.get("$questionsUrl/$id");

      return response.match(
        (failure) => Left(failure),
        (oneQuestionsResponse) =>
            Right(OneQuestionsResponse.fromJson(oneQuestionsResponse)),
      );
    } catch (e, st) {
      return Left(Failure.fromDio(e, st));
    }
  }

  @override
  Future<Result<OneQuestionsResponse>> createQuestion(
    QuestionRequest questionRequest,
  ) async {
    final data = questionRequest.toJson();
    try {
      final response = await _apiClient.post(questionsUrl, data: data);

      return response.match(
        (failure) => Left(failure),
        (oneQuestionResponse) =>
            Right(OneQuestionsResponse.fromJson(oneQuestionResponse)),
      );
    } catch (e, st) {
      return Left(Failure.fromDio(e, st));
    }
  }

  @override
  Future<Unit> deleteQuestion({required int id}) async {
    await _apiClient.delete("$questionsUrl/$id");

    return unit;
  }

  @override
  Future<Result<OneQuestionsResponse>> editQuestion(
    int id, {
    EditQuestionRequest? editQuestionRequest,
  }) async {
    final data = editQuestionRequest?.toJson();

    try {
      final response = await _apiClient.put(
        "$questionsUrl/$id",
        data: data ?? {},
      );

      return response.match(
        (failure) => Left(failure),
        (jsonMap) => Right(OneQuestionsResponse.fromJson(jsonMap)),
      );
    } catch (e, st) {
      return Left(Failure.fromDio(e, st));
    }
  }
}
