part of 'delete_question_bloc.dart';

@freezed
abstract class DeleteQuestionEvent with _$DeleteQuestionEvent {
  const factory DeleteQuestionEvent.started() = _Started;

  const factory DeleteQuestionEvent.deleteQuestion({required int id}) =
      _DeleteQuestion;
}
