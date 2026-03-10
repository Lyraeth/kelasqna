part of 'edit_question_bloc.dart';

@freezed
class EditQuestionEvent with _$EditQuestionEvent {
  const factory EditQuestionEvent.started() = _Started;

  const factory EditQuestionEvent.editQuestion(
    int id, {
    EditQuestionParams? editQuestionParams,
  }) = _EditQuestion;
}
