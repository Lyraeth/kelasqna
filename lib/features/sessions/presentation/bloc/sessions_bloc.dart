import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'sessions_bloc.freezed.dart';
part 'sessions_event.dart';
part 'sessions_state.dart';

class SessionsBloc extends Bloc<SessionsEvent, SessionsState> {
  final SessionsRepository _repository;

  SessionsBloc(this._repository) : super(const SessionsState.initial()) {
    on<_Started>(_onStarted);
    on<_LoggedIn>(_onLoggedIn);
    on<_LoggedOut>(_onLoggedOut);
  }

  Future<void> _onStarted(_Started event, Emitter<SessionsState> emit) async {
    emit(const SessionsState.loading());

    final isFirstTime = await _repository.isFirstTimeUserOpenApp();

    if (isFirstTime) {
      emit(const SessionsState.firstTime());
      return;
    }

    final token = await _repository.getAccessToken();

    if (token == null) {
      emit(const SessionsState.unauthenticated());
      return;
    }

    final result = await _repository.me();

    result.fold(
      (failure) async {
        await _repository.clearSession();
        emit(const SessionsState.unauthenticated());
      },
      (user) {
        emit(SessionsState.authenticated(user: user, accessToken: token));
      },
    );
  }

  Future<void> _onLoggedIn(_LoggedIn event, Emitter<SessionsState> emit) async {
    emit(const SessionsState.loading());

    await _repository.setAccessToken(event.token);

    sI<TokenProvider>().setToken(event.token);

    await _repository.setFirstTimeUserOpenedApp(false);

    final result = await _repository.me();

    result.fold(
      (failure) async {
        emit(const SessionsState.unauthenticated());
      },
      (user) {
        emit(SessionsState.authenticated(user: user, accessToken: event.token));
      },
    );
  }

  Future<void> _onLoggedOut(
    _LoggedOut event,
    Emitter<SessionsState> emit,
  ) async {
    await _repository.clearSession();

    sI<TokenProvider>().clearToken();

    emit(const SessionsState.unauthenticated());
  }
}
