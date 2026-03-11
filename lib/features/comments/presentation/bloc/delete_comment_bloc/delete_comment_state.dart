part of 'delete_comment_bloc.dart';

@freezed
abstract class DeleteCommentState with _$DeleteCommentState {
  const factory DeleteCommentState.initial() = _Initial;

  const factory DeleteCommentState.loading() = _Loading;

  const factory DeleteCommentState.success() = _Success;

  const factory DeleteCommentState.failure(Failure failure) = _Failure;
}
