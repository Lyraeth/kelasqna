import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'notification_response.freezed.dart';
part 'notification_response.g.dart';

@freezed
abstract class NotificationResponse with _$NotificationResponse {
  const factory NotificationResponse({
    @JsonKey(name: "data") required List<NotificationModel> listNotification,
    @JsonKey(name: "links") required LinksNotification links,
    @JsonKey(name: "meta") required MetaNotification meta,
  }) = _NotificationResponse;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);
}
