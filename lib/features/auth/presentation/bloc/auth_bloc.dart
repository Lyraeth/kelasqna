import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthBloc(this._loginUseCase, this._logoutUseCase)
    : super(const AuthState.initial()) {
    on<_LoginRequested>(_onLoginRequested);
    on<_LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    _LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _loginUseCase.call(
      LoginParams(
        email: event.loginRequest.email,
        password: event.loginRequest.password,
        deviceName: event.loginRequest.deviceName,
      ),
    );

    return result.match(
      (failure) => emit(AuthState.failure(failure)),
      (LoginResponse loginResponse) => emit(
        AuthState.successLogin(
          accessToken: loginResponse.tokens.accessToken,
          expiresAt: loginResponse.tokens.expiresAt,
        ),
      ),
    );
  }

  Future<void> _onLogoutRequested(
    _LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _logoutUseCase.call();
  }
}
