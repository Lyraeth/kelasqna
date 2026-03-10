part of 'question_bloc.dart';

@freezed
abstract class QuestionState with _$QuestionState {
  const factory QuestionState.initial() = _Initial;

  const factory QuestionState.loading() = _Loading;

  const factory QuestionState.success({required QuestionEntity question}) =
      _Success;

  const factory QuestionState.emptyComment() = _EmptyComment;

  const factory QuestionState.failure(Failure failure) = _Failure;
}
