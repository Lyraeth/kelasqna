import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'profile_comments_bloc.freezed.dart';
part 'profile_comments_event.dart';
part 'profile_comments_state.dart';

class ProfileCommentsBloc
    extends Bloc<ProfileCommentsEvent, ProfileCommentsState> {
  final FetchCommentedUserQuestionUseCase _fetchCommentedUserQuestionUseCase;

  ProfileCommentsBloc(this._fetchCommentedUserQuestionUseCase)
    : super(const ProfileCommentsState.initial()) {
    on<_Started>(_onStarted);
    on<_LoadPage>(_onLoadPage);
  }

  Future<void> _onStarted(
    _Started event,
    Emitter<ProfileCommentsState> emit,
  ) async {
    if (!event.forceRefresh && state is _HasData) return;
    await _fetchPage(1, emit);
  }

  Future<void> _onLoadPage(
    _LoadPage event,
    Emitter<ProfileCommentsState> emit,
  ) async {
    await _fetchPage(event.page, emit);
  }

  Future<void> _fetchPage(int page, Emitter<ProfileCommentsState> emit) async {
    emit(ProfileCommentsState.loading(currentPage: page));

    final result = await _fetchCommentedUserQuestionUseCase.call(page: page);

    return result.match(
      (failure) => emit(ProfileCommentsState.failure(failure)),
      (paginated) => paginated.data.isEmpty
          ? emit(const ProfileCommentsState.emptyData())
          : emit(
              ProfileCommentsState.hasData(
                listComments: paginated.data,
                currentPage: paginated.currentPage,
                totalPages: paginated.totalPages,
              ),
            ),
    );
  }
}
