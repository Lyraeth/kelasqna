import 'package:freezed_annotation/freezed_annotation.dart';

part 'links_notification.freezed.dart';
part 'links_notification.g.dart';

@freezed
abstract class LinksNotification with _$LinksNotification {
  const factory LinksNotification({String? prev, String? next}) =
      _LinksNotification;

  factory LinksNotification.fromJson(Map<String, dynamic> json) =>
      _$LinksNotificationFromJson(json);
}
