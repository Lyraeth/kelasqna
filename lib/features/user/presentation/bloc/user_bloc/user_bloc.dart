import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'user_bloc.freezed.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FetchAnotherUserUseCase _anotherUserUseCase;

  UserBloc(this._anotherUserUseCase) : super(const UserState.initial()) {
    on<_FetchAnotherUser>(_onFetchAnotherUser);
  }

  Future<void> _onFetchAnotherUser(
    _FetchAnotherUser event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserState.loading());

    final result = await _anotherUserUseCase.call(id: event.id);

    return result.match(
      (failure) => emit(UserState.failure(failure)),
      (UserEntity userEntity) =>
          emit(UserState.success(userEntity: userEntity)),
    );
  }
}
