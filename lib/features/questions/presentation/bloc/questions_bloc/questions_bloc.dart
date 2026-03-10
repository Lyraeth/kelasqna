import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'questions_bloc.freezed.dart';
part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final FetchAllQuestionsUseCase _fetchAllQuestionsUseCase;

  QuestionsBloc(this._fetchAllQuestionsUseCase)
    : super(const QuestionsState.initial()) {
    on<_Started>(_onStarted);
  }

  Future<void> _onStarted(_Started event, Emitter<QuestionsState> emit) async {
    if (!event.forceRefresh && state is _HasData) return;

    emit(const QuestionsState.loading());

    final result = await _fetchAllQuestionsUseCase.call();

    return result.match(
      (failure) => emit(QuestionsState.failure(failure)),
      (listQuestions) => listQuestions.isEmpty
          ? emit(QuestionsState.emptyData())
          : emit(QuestionsState.hasData(listQuestions: listQuestions)),
    );
  }
}
