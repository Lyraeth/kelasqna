part of 'delete_comment_bloc.dart';

@freezed
abstract class DeleteCommentEvent with _$DeleteCommentEvent {
  const factory DeleteCommentEvent.started() = _Started;

  const factory DeleteCommentEvent.deleteComment(
    int questionId,
    int commentId,
  ) = _DeleteComment;
}
