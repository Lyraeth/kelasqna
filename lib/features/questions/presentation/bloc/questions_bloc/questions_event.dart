part of 'questions_bloc.dart';

@freezed
abstract class QuestionsEvent with _$QuestionsEvent {
  const factory QuestionsEvent.started({@Default(false) bool forceRefresh}) =
      _Started;
}
