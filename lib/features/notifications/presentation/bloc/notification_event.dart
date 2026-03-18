part of 'notification_bloc.dart';

@freezed
abstract class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent.started({@Default(false) bool forceRefresh}) = _Started;

  const factory NotificationEvent.loadPage(int page) = _LoadPage;

  const factory NotificationEvent.markAsRead({required String id}) =
      _MarkAsRead;

  const factory NotificationEvent.markAllRead() = _MarkAllRead;
}
