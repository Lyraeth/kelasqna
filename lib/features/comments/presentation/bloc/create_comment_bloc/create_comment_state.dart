part of 'create_comment_bloc.dart';

@freezed
abstract class CreateCommentState with _$CreateCommentState {
  const factory CreateCommentState.initial() = _Initial;

  const factory CreateCommentState.loading() = _Loading;

  const factory CreateCommentState.success({
    required CommentsEntity commentsEntity,
  }) = _Success;

  const factory CreateCommentState.failure(Failure failure) = _Failure;
}
