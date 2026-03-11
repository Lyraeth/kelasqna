part of 'create_comment_bloc.dart';

@freezed
abstract class CreateCommentEvent with _$CreateCommentEvent {
  const factory CreateCommentEvent.started() = _Started;

  const factory CreateCommentEvent.createComment(
    int questionId, {
    required String content,
  }) = _CreateComment;
}
