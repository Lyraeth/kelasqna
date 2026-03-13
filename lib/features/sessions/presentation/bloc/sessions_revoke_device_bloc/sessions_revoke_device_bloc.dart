import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'sessions_revoke_device_bloc.freezed.dart';
part 'sessions_revoke_device_event.dart';
part 'sessions_revoke_device_state.dart';

class SessionsRevokeDeviceBloc
    extends Bloc<SessionsRevokeDeviceEvent, SessionsRevokeDeviceState> {
  final DeleteSessionDeviceUseCase _deleteSessionDeviceUseCase;

  SessionsRevokeDeviceBloc(this._deleteSessionDeviceUseCase)
    : super(const SessionsRevokeDeviceState.initial()) {
    on<_RevokeSession>(_onRevokeSession);
  }

  Future<void> _onRevokeSession(
    _RevokeSession event,
    Emitter<SessionsRevokeDeviceState> emit,
  ) async {
    emit(const SessionsRevokeDeviceState.loading());

    final result = await _deleteSessionDeviceUseCase.call(event.id);

    return result.match(
      (failure) => emit(SessionsRevokeDeviceState.failure(failure)),
      (_) => emit(SessionsRevokeDeviceState.success()),
    );
  }
}
