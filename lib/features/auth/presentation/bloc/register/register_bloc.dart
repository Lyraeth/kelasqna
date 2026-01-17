import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/features/auth/data/model/register_response.dart';
import 'package:kelasqna/features/auth/domain/usecase/auth_use_case.dart';

part 'register_bloc.freezed.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthUseCase _authUseCase;

  RegisterBloc(this._authUseCase) : super(const RegisterState.initial()) {
    on<_Register>(_onRegister);
  }

  Future<void> _onRegister(_Register event, Emitter<RegisterState> emit) async {
    emit(RegisterState.loading());

    final result = await _authUseCase.registerUser(
      name: event.name,
      username: event.username,
      password: event.password,
    );

    result.match((failure) => emit(_Failure(failure.safeMessage)), (
      registerResponse,
    ) {
      emit(RegisterState.success(registerResponse: registerResponse));
    });
  }
}
