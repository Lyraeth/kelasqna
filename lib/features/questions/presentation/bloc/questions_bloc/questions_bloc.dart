import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'questions_bloc.freezed.dart';
part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final FetchAllQuestionsUseCase _fetchAllQuestionsUseCase;
  final LikeQuestionUseCase _likeQuestionUseCase;
  final BookmarkQuestionUseCase _bookmarkQuestionUseCase;

  QuestionsBloc(
    this._fetchAllQuestionsUseCase,
    this._likeQuestionUseCase,
    this._bookmarkQuestionUseCase,
  ) : super(const QuestionsState.initial()) {
    on<_Started>(_onStarted);
    on<_LoadPage>(_onLoadPage);
    on<_ToggleLike>(_onToggleLike);
    on<_ToggleBookmark>(_onToggleBookmark);
  }

  Future<void> _onStarted(_Started event, Emitter<QuestionsState> emit) async {
    if (!event.forceRefresh && state is _HasData) return;
    await _fetchPage(1, emit);
  }

  Future<void> _onLoadPage(
    _LoadPage event,
    Emitter<QuestionsState> emit,
  ) async {
    await _fetchPage(event.page, emit);
  }

  Future<void> _fetchPage(int page, Emitter<QuestionsState> emit) async {
    emit(QuestionsState.loading(currentPage: page));

    final result = await _fetchAllQuestionsUseCase.call(page: page);

    return result.match(
      (failure) => emit(QuestionsState.failure(failure)),
      (paginated) => paginated.data.isEmpty
          ? emit(QuestionsState.emptyData())
          : emit(
              QuestionsState.hasData(
                listQuestions: paginated.data,
                currentPage: paginated.currentPage,
                totalPages: paginated.totalPages,
              ),
            ),
    );
  }

  Future<void> _onToggleLike(
    _ToggleLike event,
    Emitter<QuestionsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! _HasData) return;

    final updatedList = currentState.listQuestions.map((question) {
      if (question.id != event.id) return question;

      final isLiked = !question.engagementReact.isLiked;

      return question.copyWith(
        engagementReact: question.engagementReact.copyWith(isLiked: isLiked),
        engagementTotal: question.engagementTotal.copyWith(
          totalLikes: isLiked
              ? question.engagementTotal.totalLikes + 1
              : question.engagementTotal.totalLikes - 1,
        ),
      );
    }).toList();

    emit(currentState.copyWith(listQuestions: updatedList));

    final result = await _likeQuestionUseCase.call(event.id);

    return result.match((failure) => emit(currentState), (_) {});
  }

  Future<void> _onToggleBookmark(
    _ToggleBookmark event,
    Emitter<QuestionsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! _HasData) return;

    final updatedList = currentState.listQuestions.map((question) {
      if (question.id != event.id) return question;

      final isBookmarked = !question.engagementReact.isBookmarked;

      return question.copyWith(
        engagementReact: question.engagementReact.copyWith(
          isBookmarked: isBookmarked,
        ),
        engagementTotal: question.engagementTotal.copyWith(
          totalBookmarks: isBookmarked
              ? question.engagementTotal.totalBookmarks + 1
              : question.engagementTotal.totalBookmarks - 1,
        ),
      );
    }).toList();

    emit(currentState.copyWith(listQuestions: updatedList));

    final result = await _bookmarkQuestionUseCase.call(event.id);

    return result.match((failure) => emit(currentState), (_) {});
  }
}
