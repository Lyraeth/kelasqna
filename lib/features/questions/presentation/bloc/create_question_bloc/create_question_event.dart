part of 'create_question_bloc.dart';

@freezed
abstract class CreateQuestionEvent with _$CreateQuestionEvent {
  const factory CreateQuestionEvent.started() = _Started;

  const factory CreateQuestionEvent.createQuestion({
    required QuestionParams questionParams,
  }) = _CreateQuestion;
}
