part of 'profile_comments_bloc.dart';

@freezed
abstract class ProfileCommentsState with _$ProfileCommentsState {
  const factory ProfileCommentsState.initial() = _Initial;

  const factory ProfileCommentsState.loading({@Default(1) int currentPage}) =
      _Loading;

  const factory ProfileCommentsState.emptyData() = _EmptyData;

  const factory ProfileCommentsState.hasData({
    required List<CommentsEntity> listComments,
    required int currentPage,
    required int totalPages,
  }) = _HasData;

  const factory ProfileCommentsState.failure(Failure failure) = _Failure;
}
