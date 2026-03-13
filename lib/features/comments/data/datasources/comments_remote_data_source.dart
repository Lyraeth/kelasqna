import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

abstract class CommentsRemoteDataSource {
  Future<Result<CommentsResponse>> createComment(
    int questionId, {
    required String content,
  });

  Future<Result<CommentsResponse>> editComment(
    int questionId,
    int commentId, {
    String? content,
  });

  Future<Unit> deleteComment(int questionId, int commentId);
}

class CommentsRemoteDataSourceImpl implements CommentsRemoteDataSource {
  final ApiClient _apiClient;

  CommentsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<CommentsResponse>> createComment(
    int questionId, {
    required String content,
  }) async {
    final Map<String, dynamic> data = {"content": content};

    try {
      final response = await _apiClient.post(
        "$questionsUrl/$questionId/comments",
        data: data,
      );

      return response.match(
        (failure) => Left(failure),
        (jsonMap) => Right(CommentsResponse.fromJson(jsonMap)),
      );
    } catch (e, st) {
      return Left(Failure.fromDio(e, st));
    }
  }

  @override
  Future<Unit> deleteComment(int questionId, int commentId) async {
    await _apiClient.delete("$questionsUrl/$questionId/comments/$commentId");

    return unit;
  }

  @override
  Future<Result<CommentsResponse>> editComment(
    int questionId,
    int commentId, {
    String? content,
  }) async {
    final Map<String, dynamic> data = {"content": content};

    try {
      final response = await _apiClient.put(
        "$questionsUrl/$questionId/comments/$commentId",
        data: data,
      );

      return response.match(
        (failure) => Left(failure),
        (jsonMap) => Right(CommentsResponse.fromJson(jsonMap)),
      );
    } catch (e, st) {
      return Left(Failure.fromDio(e, st));
    }
  }
}
