part of 'profile_bookmarks_bloc.dart';

@freezed
abstract class ProfileBookmarksEvent with _$ProfileBookmarksEvent {
  const factory ProfileBookmarksEvent.started({
    @Default(false) bool forceRefresh,
  }) = _Started;

  const factory ProfileBookmarksEvent.loadPage(int page) = _LoadPage;
}
