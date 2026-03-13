import 'package:kelasqna/kelasqna.dart';

class EditCommentUseCase {
  final CommentsRepository _commentsRepository;

  EditCommentUseCase(this._commentsRepository);

  Future<Result<CommentsEntity>> call(
    int questionId,
    int commentId, {
    String? content,
  }) async =>
      _commentsRepository.editComment(questionId, commentId, content: content);
}
