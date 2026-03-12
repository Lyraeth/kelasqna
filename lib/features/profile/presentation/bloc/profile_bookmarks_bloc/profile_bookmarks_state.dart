part of 'profile_bookmarks_bloc.dart';

@freezed
abstract class ProfileBookmarksState with _$ProfileBookmarksState {
  const factory ProfileBookmarksState.initial() = _Initial;

  const factory ProfileBookmarksState.loading({@Default(1) int currentPage}) =
      _Loading;

  const factory ProfileBookmarksState.emptyData() = _EmptyData;

  const factory ProfileBookmarksState.hasData({
    required List<QuestionEntity> listBookmarks,
    required int currentPage,
    required int totalPages,
  }) = _HasData;

  const factory ProfileBookmarksState.failure(Failure failure) = _Failure;
}
