part of 'edit_comment_bloc.dart';

@freezed
abstract class EditCommentState with _$EditCommentState {
  const factory EditCommentState.initial() = _Initial;

  const factory EditCommentState.loading() = _Loading;

  const factory EditCommentState.success({
    required CommentsEntity commentsEntity,
  }) = _Success;

  const factory EditCommentState.failure(Failure failure) = _Failure;
}
