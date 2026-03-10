part of 'edit_question_bloc.dart';

@freezed
abstract class EditQuestionState with _$EditQuestionState {
  const factory EditQuestionState.initial() = _Initial;

  const factory EditQuestionState.loading() = _Loading;

  const factory EditQuestionState.success({
    required QuestionEntity questionEntity,
  }) = _Success;

  const factory EditQuestionState.failure(Failure failure) = _Failure;
}
