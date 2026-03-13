import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

abstract class CommentsRepository {
  Future<Result<CommentsEntity>> createComment(
    int questionId, {
    required String content,
  });

  Future<Result<CommentsEntity>> editComment(
    int questionId,
    int commentId, {
    String? content,
  });

  Future<Unit> deleteComment(int questionId, int commentId);
}
