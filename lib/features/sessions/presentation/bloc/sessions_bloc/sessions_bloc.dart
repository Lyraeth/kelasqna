import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'sessions_bloc.freezed.dart';
part 'sessions_event.dart';
part 'sessions_state.dart';

class SessionsBloc extends Bloc<SessionsEvent, SessionsState> {
  final GetAccessTokenUseCase _getAccessTokenUseCase;
  final SaveAccessTokenUseCase _saveAccessTokenUseCase;
  final MeUseCase _meUseCase;
  final ClearSessionUseCase _clearSessionUseCase;
  final GetLoggedUserDetailsUseCase _getLoggedUserDetailsUseCase;
  final SaveLoggedUserDetailsUseCase _saveLoggedUserDetailsUseCase;
  final IsFirstTimeUserOpenAppUseCase _isFirstTimeUserOpenAppUseCase;
  final SetFirstTimeUserOpenedAppUseCase _setFirstTimeUserOpenedAppUseCase;

  SessionsBloc(
    this._saveAccessTokenUseCase,
    this._clearSessionUseCase,
    this._meUseCase,
    this._getAccessTokenUseCase,
    this._getLoggedUserDetailsUseCase,
    this._saveLoggedUserDetailsUseCase,
    this._isFirstTimeUserOpenAppUseCase,
    this._setFirstTimeUserOpenedAppUseCase,
  ) : super(const SessionsState.initial()) {
    on<_Started>(_onStarted);
    on<_LoggedIn>(_onLoggedIn);
    on<_LoggedOut>(_onLoggedOut);
  }

  Future<void> _onStarted(_Started event, Emitter<SessionsState> emit) async {
    emit(const SessionsState.loading());

    final isFirstTime = await _isFirstTimeUserOpenAppUseCase.call();

    if (isFirstTime) {
      emit(const SessionsState.firstTime());
      debugPrint(
        "SessionsState.firstTime() because await _isFirstTimeUserOpenAppUseCase.call() is true",
      );
      return;
    }

    final storedAccessToken = await _getAccessTokenUseCase.call();

    if (storedAccessToken == null) {
      emit(const SessionsState.unauthenticated());
      debugPrint(
        "SessionsState.unauthenticated() because await _getAccessTokenUseCase.call() is null",
      );
      return;
    }

    final storedUserDetails = _getLoggedUserDetailsUseCase.call();

    if (storedUserDetails != null) {
      debugPrint(
        "SessionsState.authenticated() because _getLoggedUserDetailsUseCase.call() has user data",
      );
      emit(
        SessionsState.authenticated(
          user: storedUserDetails,
          accessToken: storedAccessToken,
          isRefreshing: true,
        ),
      );
    }

    final result = await _meUseCase.call();

    final failure = result.match((f) => f, (r) => null);
    final meResponse = result.match((l) => null, (r) => r);

    if (failure != null) {
      await _clearSessionUseCase.call();
      debugPrint("await _clearSessionUseCase.call() success");

      sI<TokenProvider>().clearToken();
      debugPrint("sI<TokenProvider>().clearToken() success");

      emit(const SessionsState.unauthenticated());
      debugPrint("SessionsState.unauthenticated() because failure is not null");

      return;
    }

    if (meResponse != null) {
      await _saveLoggedUserDetailsUseCase.call(meResponse.user.toEntity());
      debugPrint(
        "await _saveLoggedUserDetailsUseCase.call(meResponse) updated",
      );
      emit(
        SessionsState.authenticated(
          user: meResponse.user.toEntity(),
          accessToken: storedAccessToken,
          isRefreshing: false,
        ),
      );
    }
  }

  Future<void> _onLoggedIn(_LoggedIn event, Emitter<SessionsState> emit) async {
    emit(const SessionsState.loading());

    await _saveAccessTokenUseCase.call(event.token);

    sI<TokenProvider>().setToken(event.token);

    await _setFirstTimeUserOpenedAppUseCase.call(false);

    final result = await _meUseCase.call();

    final failure = result.match((f) => f, (_) => null);
    final meResponse = result.match((_) => null, (m) => m);

    if (failure != null) {
      await _clearSessionUseCase.call();
      sI<TokenProvider>().clearToken();
      emit(const SessionsState.unauthenticated());
      return;
    }

    if (meResponse != null) {
      await _saveLoggedUserDetailsUseCase.call(meResponse.user.toEntity());
      emit(
        SessionsState.authenticated(
          user: meResponse.user.toEntity(),
          accessToken: event.token,
        ),
      );
    }
  }

  Future<void> _onLoggedOut(
    _LoggedOut event,
    Emitter<SessionsState> emit,
  ) async {
    await _clearSessionUseCase.call();

    sI<TokenProvider>().clearToken();

    emit(const SessionsState.unauthenticated());
  }

  int? get getUserId => state.whenOrNull(
    authenticated: (user, accessToken, isRefreshing) => user.id,
  );
}
