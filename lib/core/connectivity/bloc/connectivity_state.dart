part of 'connectivity_bloc.dart';

@freezed
abstract class ConnectivityState with _$ConnectivityState {
  const ConnectivityState._();

  const factory ConnectivityState({
    @Default(ConnectivityStatus.unknown) ConnectivityStatus connectivityStatus,
  }) = _ConnectivityState;

  bool get isConnected => connectivityStatus == ConnectivityStatus.connected;

  bool get isDisconnected =>
      connectivityStatus == ConnectivityStatus.disconnected;
}
