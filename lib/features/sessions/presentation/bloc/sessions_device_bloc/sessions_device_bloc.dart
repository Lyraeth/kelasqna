import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'sessions_device_bloc.freezed.dart';
part 'sessions_device_event.dart';
part 'sessions_device_state.dart';

class SessionsDeviceBloc
    extends Bloc<SessionsDeviceEvent, SessionsDeviceState> {
  final FetchSessionsDeviceUseCase _fetchSessionsDeviceUseCase;

  SessionsDeviceBloc(this._fetchSessionsDeviceUseCase)
    : super(const SessionsDeviceState.initial()) {
    on<_Started>(_onStarted);
  }

  Future<void> _onStarted(
    _Started event,
    Emitter<SessionsDeviceState> emit,
  ) async {
    if (!event.forceRefresh && state is _Success) return;

    emit(const SessionsDeviceState.loading());

    final result = await _fetchSessionsDeviceUseCase.call();

    return result.match(
      (failure) => emit(SessionsDeviceState.failure(failure)),
      (List<SessionsDeviceEntity> listSessionDevice) => emit(
        SessionsDeviceState.success(listSessionDevice: listSessionDevice),
      ),
    );
  }
}
