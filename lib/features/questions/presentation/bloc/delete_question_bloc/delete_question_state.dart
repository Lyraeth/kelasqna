part of 'delete_question_bloc.dart';

@freezed
abstract class DeleteQuestionState with _$DeleteQuestionState {
  const factory DeleteQuestionState.initial() = _Initial;

  const factory DeleteQuestionState.loading() = _Loading;

  const factory DeleteQuestionState.success() = _Success;

  const factory DeleteQuestionState.failure(Failure failure) = _Failure;
}
