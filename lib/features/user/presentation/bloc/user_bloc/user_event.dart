part of 'user_bloc.dart';

@freezed
abstract class UserEvent with _$UserEvent {
  const factory UserEvent.started() = _Started;

  const factory UserEvent.fetchAnotherUser({required int id}) = _FetchAnotherUser;
}
