part of 'profile_questions_bloc.dart';

@freezed
abstract class ProfileQuestionsEvent with _$ProfileQuestionsEvent {
  const factory ProfileQuestionsEvent.started({
    int? userId,
    @Default(false) bool forceRefresh,
  }) = _Started;

  const factory ProfileQuestionsEvent.loadPage(int page) = _LoadPage;
}
