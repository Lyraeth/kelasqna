part of 'edit_comment_bloc.dart';

@freezed
abstract class EditCommentEvent with _$EditCommentEvent {
  const factory EditCommentEvent.started() = _Started;

  const factory EditCommentEvent.editComment(
    int questionId,
    int commentId, {
    String? content,
  }) = _EditComment;
}
