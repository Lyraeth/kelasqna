import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_entity.freezed.dart';

@freezed
abstract class NotificationEntity with _$NotificationEntity {
  const factory NotificationEntity({
    required String id,
    required String type,
    required String message,
    required Map<String, dynamic> data,
    @Default(false) bool isRead,
    String? readAt,
    required String createdAt,
  }) = _NotificationEntity;
}
