import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'profile_questions_bloc.freezed.dart';
part 'profile_questions_event.dart';
part 'profile_questions_state.dart';

class ProfileQuestionsBloc
    extends Bloc<ProfileQuestionsEvent, ProfileQuestionsState> {
  final FetchCreatedUserQuestionUseCase _fetchCreatedUserQuestionUseCase;

  ProfileQuestionsBloc(this._fetchCreatedUserQuestionUseCase)
    : super(const ProfileQuestionsState.initial()) {
    on<_Started>(_onStarted);
    on<_LoadPage>(_onLoadPage);
  }

  Future<void> _onStarted(
    _Started event,
    Emitter<ProfileQuestionsState> emit,
  ) async {
    if (!event.forceRefresh && state is _HasData) return;
    await _fetchPage(1, emit);
  }

  Future<void> _onLoadPage(
    _LoadPage event,
    Emitter<ProfileQuestionsState> emit,
  ) async {
    await _fetchPage(event.page, emit);
  }

  Future<void> _fetchPage(int page, Emitter<ProfileQuestionsState> emit) async {
    emit(ProfileQuestionsState.loading(currentPage: page));

    final result = await _fetchCreatedUserQuestionUseCase.call(page: page);

    return result.match(
      (failure) => emit(ProfileQuestionsState.failure(failure)),
      (paginated) => paginated.data.isEmpty
          ? emit(const ProfileQuestionsState.emptyData())
          : emit(
              ProfileQuestionsState.hasData(
                listQuestions: paginated.data,
                currentPage: paginated.currentPage,
                totalPages: paginated.totalPages,
              ),
            ),
    );
  }
}
