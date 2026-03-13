import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class DeleteCommentUseCase {
  final CommentsRepository _commentsRepository;

  DeleteCommentUseCase(this._commentsRepository);

  Future<Unit> call(int questionId, int commentId) async =>
      _commentsRepository.deleteComment(questionId, commentId);
}
