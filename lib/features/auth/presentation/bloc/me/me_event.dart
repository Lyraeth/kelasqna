part of 'me_bloc.dart';

@freezed
abstract class MeEvent with _$MeEvent {
  const factory MeEvent.getDataViaJwt() = _GetDataViaJwt;
}
