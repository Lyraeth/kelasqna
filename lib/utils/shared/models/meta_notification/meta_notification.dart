import 'package:freezed_annotation/freezed_annotation.dart';

part 'meta_notification.freezed.dart';
part 'meta_notification.g.dart';

@freezed
abstract class MetaNotification with _$MetaNotification {
  const factory MetaNotification({
    @JsonKey(name: "current_page") required int currentPage,
    @JsonKey(name: "last_page") required int lastPage,
    @JsonKey(name: "per_page") required int perPage,
    required int total,
    @JsonKey(name: "unread_count") required int unreadCount,
  }) = _MetaNotification;

  factory MetaNotification.fromJson(Map<String, dynamic> json) =>
      _$MetaNotificationFromJson(json);
}
