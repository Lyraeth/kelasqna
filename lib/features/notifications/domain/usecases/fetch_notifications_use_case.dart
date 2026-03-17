import 'package:kelasqna/kelasqna.dart';

class FetchNotificationsUseCase {
  final NotificationRepository _notificationRepository;

  FetchNotificationsUseCase(this._notificationRepository);

  Future<Result<PaginatedResult<NotificationEntity>>> call({
    int page = 1,
  }) async => await _notificationRepository.fetchNotifications(page: page);
}
