part of 'questions_bloc.dart';

@freezed
abstract class QuestionsState with _$QuestionsState {
  const factory QuestionsState.initial() = _Initial;

  const factory QuestionsState.loading() = _Loading;

  const factory QuestionsState.hasData({
    required List<QuestionEntity> listQuestions,
  }) = _HasData;

  const factory QuestionsState.emptyData() = _EmptyData;

  const factory QuestionsState.failure(Failure failure) = _Failure;
}
