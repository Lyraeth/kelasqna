import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'profile_bookmarks_bloc.freezed.dart';
part 'profile_bookmarks_event.dart';
part 'profile_bookmarks_state.dart';

class ProfileBookmarksBloc
    extends Bloc<ProfileBookmarksEvent, ProfileBookmarksState> {
  final FetchBookmarkedUserQuestionUseCase _fetchBookmarkedUserQuestionUseCase;

  ProfileBookmarksBloc(this._fetchBookmarkedUserQuestionUseCase)
    : super(const ProfileBookmarksState.initial()) {
    on<_Started>(_onStarted);
    on<_LoadPage>(_onLoadPage);
  }

  Future<void> _onStarted(
    _Started event,
    Emitter<ProfileBookmarksState> emit,
  ) async {
    if (!event.forceRefresh && state is _HasData) return;
    await _fetchPage(1, emit);
  }

  Future<void> _onLoadPage(
    _LoadPage event,
    Emitter<ProfileBookmarksState> emit,
  ) async {
    await _fetchPage(event.page, emit);
  }

  Future<void> _fetchPage(int page, Emitter<ProfileBookmarksState> emit) async {
    emit(ProfileBookmarksState.loading(currentPage: page));

    final result = await _fetchBookmarkedUserQuestionUseCase.call(page: page);

    return result.match(
      (failure) => emit(ProfileBookmarksState.failure(failure)),
      (paginated) => paginated.data.isEmpty
          ? emit(const ProfileBookmarksState.emptyData())
          : emit(
              ProfileBookmarksState.hasData(
                listBookmarks: paginated.data,
                currentPage: paginated.currentPage,
                totalPages: paginated.totalPages,
              ),
            ),
    );
  }
}
