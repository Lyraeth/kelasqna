import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class MarkAsReadUseCase {
  final NotificationRepository _notificationRepository;

  MarkAsReadUseCase(this._notificationRepository);

  Future<Result<Unit>> call({required String id}) async =>
      await _notificationRepository.markAsRead(id: id);
}
