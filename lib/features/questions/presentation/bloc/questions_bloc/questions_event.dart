part of 'questions_bloc.dart';

@freezed
abstract class QuestionsEvent with _$QuestionsEvent {
  const factory QuestionsEvent.started({@Default(false) bool forceRefresh}) =
      _Started;

  const factory QuestionsEvent.loadPage(int page) = _LoadPage;

  const factory QuestionsEvent.toggleLike({required int id}) = _ToggleLike;

  const factory QuestionsEvent.toggleBookmark({required int id}) =
      _ToggleBookmark;
}
