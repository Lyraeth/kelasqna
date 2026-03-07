import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'user_bloc.freezed.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final RegisterUseCase _registerUseCase;

  UserBloc(this._registerUseCase) : super(const UserState.initial()) {
    on<_Register>(_onRegister);
  }

  Future<void> _onRegister(_Register event, Emitter<UserState> emit) async {
    final UserRegisterParams params = UserRegisterParams(
      name: event.userRegisterParams.name,
      email: event.userRegisterParams.email,
      password: event.userRegisterParams.password,
      passwordConfirmation: event.userRegisterParams.passwordConfirmation,
    );

    emit(const UserState.loading());

    final result = await _registerUseCase.call(params);

    final failure = result.match((failure) => failure, (r) => null);
    final registerResponse = result.match(
      (f) => null,
      (registerResponse) => registerResponse,
    );

    if (failure != null) {
      emit(UserState.failure(failure));
      return;
    }

    if (registerResponse != null) {
      emit(UserState.success(user: registerResponse.userModel.toEntity()));
    }
  }
}
