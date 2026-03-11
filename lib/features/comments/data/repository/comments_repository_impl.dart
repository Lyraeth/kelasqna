import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class CommentsRepositoryImpl implements CommentsRepository {
  final CommentsRemoteDataSource _remoteDataSource;

  CommentsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<CommentsEntity>> createComment(
    int questionId, {
    required String content,
  }) async {
    final response = await _remoteDataSource.createComment(
      questionId,
      content: content,
    );

    return response.match(
      (failure) => Left(failure),
      (CommentsResponse commentsResponse) =>
          Right(commentsResponse.comment.toEntity()),
    );
  }

  @override
  Future<Unit> deleteComment(int questionId, int commentId) async {
    await _remoteDataSource.deleteComment(questionId, commentId);

    return unit;
  }

  @override
  Future<Result<CommentsEntity>> editComment(
    int questionId,
    int commentId, {
    String? content,
  }) async {
    final response = await _remoteDataSource.editComment(
      questionId,
      commentId,
      content: content,
    );

    return response.match(
      (failure) => Left(failure),
      (CommentsResponse commentsResponse) =>
          Right(commentsResponse.comment.toEntity()),
    );
  }
}
