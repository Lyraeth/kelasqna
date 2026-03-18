import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class MarkAllAsReadUseCase {
  final NotificationRepository _notificationRepository;

  MarkAllAsReadUseCase(this._notificationRepository);

  Future<Result<Unit>> call() async =>
      await _notificationRepository.markAllAsRead();
}
