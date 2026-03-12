part of 'profile_questions_bloc.dart';

@freezed
abstract class ProfileQuestionsState with _$ProfileQuestionsState {
  const factory ProfileQuestionsState.initial() = _Initial;

  const factory ProfileQuestionsState.loading({@Default(1) int currentPage}) =
      _Loading;

  const factory ProfileQuestionsState.emptyData() = _EmptyData;

  const factory ProfileQuestionsState.hasData({
    required List<QuestionEntity> listQuestions,
    required int currentPage,
    required int totalPages,
  }) = _HasData;

  const factory ProfileQuestionsState.failure(Failure failure) = _Failure;
}
