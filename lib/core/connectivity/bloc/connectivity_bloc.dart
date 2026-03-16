import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'connectivity_bloc.freezed.dart';
part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final ConnectivityService _connectivityService;

  ConnectivityBloc({required ConnectivityService connectivityService})
    : _connectivityService = connectivityService,
      super(const ConnectivityState()) {
    on<_Started>(_onStarted);
    on<_ConnectivityChanged>(_onChanged);
  }

  Future<void> _onStarted(
    _Started event,
    Emitter<ConnectivityState> emit,
  ) async {
    /// Have to wait first frame to be loaded before checking the internet
    await WidgetsBinding.instance.endOfFrame;

    final hasInternet = await _connectivityService.hasInternetAccess;
    emit(
      state.copyWith(
        connectivityStatus: hasInternet
            ? ConnectivityStatus.connected
            : ConnectivityStatus.disconnected,
      ),
    );

    await emit.forEach<List<ConnectivityResult>>(
      _connectivityService.onConnectivityChanged,
      onData: (results) {
        add(ConnectivityEvent.changed(results));
        return state;
      },
    );
  }

  Future<void> _onChanged(
    _ConnectivityChanged event,
    Emitter<ConnectivityState> emit,
  ) async {
    final hasNetworkInterface =
        !event.results.contains(ConnectivityResult.none) &&
        event.results.isNotEmpty;

    if (!hasNetworkInterface) {
      emit(state.copyWith(connectivityStatus: ConnectivityStatus.disconnected));
      return;
    }

    final hasInternet = await _connectivityService.hasInternetAccess;
    emit(
      state.copyWith(
        connectivityStatus: hasInternet
            ? ConnectivityStatus.connected
            : ConnectivityStatus.disconnected,
      ),
    );
  }
}
