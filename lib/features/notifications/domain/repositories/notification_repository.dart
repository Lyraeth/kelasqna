import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

abstract class NotificationRepository {
  Future<Result<PaginatedResult<NotificationEntity>>> fetchNotifications({
    int page = 1,
  });

  Future<Result<Unit>> markAsRead({required String id});

  Future<Result<Unit>> markAllAsRead();
}
