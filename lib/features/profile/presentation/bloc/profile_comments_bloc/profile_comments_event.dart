part of 'profile_comments_bloc.dart';

@freezed
abstract class ProfileCommentsEvent with _$ProfileCommentsEvent {
  const factory ProfileCommentsEvent.started({
    @Default(false) bool forceRefresh,
  }) = _Started;

  const factory ProfileCommentsEvent.loadPage(int page) = _LoadPage;
}
