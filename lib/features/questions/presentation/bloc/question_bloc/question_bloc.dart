import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'question_bloc.freezed.dart';
part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final FetchQuestionUseCase _fetchQuestionUseCase;

  QuestionBloc(this._fetchQuestionUseCase)
    : super(const QuestionState.initial()) {
    on<_FetchQuestion>(_onFetchQuestion);
  }

  Future<void> _onFetchQuestion(
    _FetchQuestion event,
    Emitter<QuestionState> emit,
  ) async {
    if (!event.forceRefresh && state is _Success) return;

    final result = await _fetchQuestionUseCase.call(id: event.id);

    return result.match(
      (failure) => emit(QuestionState.failure(failure)),
      (question) => question.listComments!.isEmpty
          ? emit(QuestionState.emptyComment())
          : emit(QuestionState.success(question: question)),
    );
  }

  int? get getAuthorId =>
      state.whenOrNull(success: (question) => question.author.id);
}
