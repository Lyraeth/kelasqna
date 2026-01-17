import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/features/auth/data/model/user_response/user_response.dart';
import 'package:kelasqna/features/auth/domain/usecase/auth_use_case.dart';

part 'me_bloc.freezed.dart';
part 'me_event.dart';
part 'me_state.dart';

class MeBloc extends Bloc<MeEvent, MeState> {
  final AuthUseCase _authUseCase;

  MeBloc(this._authUseCase) : super(const MeState.initial()) {
    on<_GetDataViaJwt>(_onGetDataViaJwt);
  }

  Future<void> _onGetDataViaJwt(
    _GetDataViaJwt event,
    Emitter<MeState> emit,
  ) async {
    emit(MeState.loading());

    final result = await _authUseCase.me();

    result.match((failure) => emit(_Failure(failure.safeMessage)), (
      userResponse,
    ) {
      emit(MeState.success(userResponse: userResponse));
    });
  }
}
