part of 'question_bloc.dart';

@freezed
abstract class QuestionEvent with _$QuestionEvent {
  const factory QuestionEvent.fetchQuestion(
    int id, {
    @Default(false) bool forceRefresh,
  }) = _FetchQuestion;
}
