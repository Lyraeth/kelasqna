part of 'connectivity_bloc.dart';

@freezed
sealed class ConnectivityEvent with _$ConnectivityEvent {
  const factory ConnectivityEvent.started() = _Started;

  const factory ConnectivityEvent.changed(List<ConnectivityResult> results) =
      _ConnectivityChanged;
}
