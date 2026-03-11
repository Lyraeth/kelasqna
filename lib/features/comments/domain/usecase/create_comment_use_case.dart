import 'package:kelasqna/kelasqna.dart';

class CreateCommentUseCase {
  final CommentsRepository _commentsRepository;

  CreateCommentUseCase(this._commentsRepository);

  Future<Result<CommentsEntity>> call(
    int questionId, {
    required String content,
  }) async => _commentsRepository.createComment(questionId, content: content);
}
