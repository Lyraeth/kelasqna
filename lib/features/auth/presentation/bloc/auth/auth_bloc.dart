import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/features/auth/domain/entity/user_entity.dart';
import 'package:kelasqna/features/auth/domain/usecase/auth_use_case.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _authUseCase;

  AuthBloc(this._authUseCase) : super(const AuthState.initial()) {
    on<_AuthenticatedUser>(_onAuthenticatedUser);
  }

  void _onAuthenticatedUser(_AuthenticatedUser event, Emitter<AuthState> emit) {
    emit(_Authenticated(timeAuth: DateTime.now()));
  }

  Future<String?> get getJwtToken async => await _authUseCase.getJwtToken;

  UserEntity? get getUserDetails => _authUseCase.getUserDetails;
}
