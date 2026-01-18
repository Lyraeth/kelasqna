import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/features/auth/domain/usecase/auth_use_case.dart';
import 'package:kelasqna/features/auth/presentation/bloc/auth/auth_bloc.dart';

part 'sign_in_bloc.freezed.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthUseCase _authUseCase;
  final AuthBloc _authBloc;

  SignInBloc(this._authUseCase, this._authBloc)
    : super(const SignInState.initial()) {
    on<_Started>(_onStarted);
    on<_RememberMeChanged>(_onRememberMeChanged);
    on<_Login>(_onLogin);
  }

  Future<void> _onStarted(_Started event, Emitter<SignInState> emit) async {
    final username = await _authUseCase.getUsernameFromRememberMe();

    emit(
      SignInState.initial(
        isRemembered: username != null && username.isNotEmpty,
        rememberedUsername: username,
      ),
    );
  }

  void _onRememberMeChanged(
    _RememberMeChanged event,
    Emitter<SignInState> emit,
  ) {
    state.maybeWhen(
      initial: (isRemembered, rememberedUsername) {
        emit(
          SignInState.initial(
            isRemembered: event.value,
            rememberedUsername: event.username,
          ),
        );
      },
      orElse: () {},
    );
  }

  Future<void> _onLogin(_Login event, Emitter<SignInState> emit) async {
    final currentState = state;

    if (currentState is! _Initial) return;

    emit(
      SignInState.loading(
        isRemembered: currentState.isRemembered,
        rememberedUsername: currentState.rememberedUsername,
      ),
    );

    final result = await _authUseCase.login(
      username: event.username,
      password: event.password,
    );

    await result.match(
      (failure) {
        emit(
          SignInState.failure(
            errorMessage: failure.safeMessage,
            detailedErrorMessage: failure.safeDetailedMessage,
          ),
        );
        emit(SignInState.initial());
      },
      (authResponse) async {
        if (currentState.isRemembered) {
          await _authUseCase.setUsernameFromRememberMe(event.username);
        } else {
          await _authUseCase.setUsernameFromRememberMe("");
        }

        emit(const SignInState.success());
        _authBloc.add(AuthEvent.authenticateUser());
      },
    );
  }
}
