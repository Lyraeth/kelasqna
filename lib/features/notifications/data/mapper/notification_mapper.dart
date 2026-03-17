import 'package:kelasqna/kelasqna.dart';

extension NotificationModelMapper on NotificationModel {
  NotificationEntity toEntity() => NotificationEntity(
    id: id,
    type: type,
    message: message,
    data: data,
    isRead: isRead,
    readAt: readAt,
    createdAt: createdAt,
  );
}
