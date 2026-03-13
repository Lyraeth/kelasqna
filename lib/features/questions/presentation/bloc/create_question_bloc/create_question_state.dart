part of 'create_question_bloc.dart';

@freezed
class CreateQuestionState with _$CreateQuestionState {
  const factory CreateQuestionState.initial() = _Initial;

  const factory CreateQuestionState.loading() = _Loading;

  const factory CreateQuestionState.success({
    required QuestionEntity questionEntity,
  }) = _Success;

  const factory CreateQuestionState.failure(Failure failure) = _Failure;
}
