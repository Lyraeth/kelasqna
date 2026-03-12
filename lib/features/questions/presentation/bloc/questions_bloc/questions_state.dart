part of 'questions_bloc.dart';

@freezed
abstract class QuestionsState with _$QuestionsState {
  const factory QuestionsState.initial() = _Initial;

  const factory QuestionsState.loading({@Default(1) int currentPage}) =
      _Loading;

  const factory QuestionsState.hasData({
    required List<QuestionEntity> listQuestions,
    required int currentPage,
    required int totalPages,
  }) = _HasData;

  const factory QuestionsState.emptyData() = _EmptyData;

  const factory QuestionsState.failure(Failure failure) = _Failure;
}
