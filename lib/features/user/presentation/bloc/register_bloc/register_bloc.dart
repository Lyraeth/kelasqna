import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'register_bloc.freezed.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterBloc(this._registerUseCase) : super(const RegisterState.initial()) {
    on<_Register>(_onRegister);
  }

  Future<void> _onRegister(_Register event, Emitter<RegisterState> emit) async {
    final UserRegisterParams params = event.userRegisterParams;

    emit(const RegisterState.loading());

    final result = await _registerUseCase.call(params);

    final failure = result.match((failure) => failure, (r) => null);

    final registerResponse = result.match(
      (f) => null,
      (registerResponse) => registerResponse,
    );

    if (failure != null) {
      emit(RegisterState.failure(failure));
      return;
    }

    if (registerResponse != null) {
      emit(RegisterState.success(user: registerResponse.userModel.toEntity()));
    }
  }
}
