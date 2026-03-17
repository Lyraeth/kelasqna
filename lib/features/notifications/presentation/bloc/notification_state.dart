part of 'notification_bloc.dart';

@freezed
abstract class NotificationState with _$NotificationState {
  const factory NotificationState.initial() = _Initial;

  const factory NotificationState.loading({@Default(1) int currentPage}) =
      _Loading;

  const factory NotificationState.hasData({
    required List<NotificationEntity> listNotification,
    required int currentPage,
    required int totalPages,
  }) = _HasData;

  const factory NotificationState.emptyData() = _EmptyData;

  const factory NotificationState.failure(Failure failure) = _Failure;
}
