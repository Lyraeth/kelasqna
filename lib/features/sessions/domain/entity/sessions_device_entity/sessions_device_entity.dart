import 'package:freezed_annotation/freezed_annotation.dart';

part 'sessions_device_entity.freezed.dart';

@freezed
abstract class SessionsDeviceEntity with _$SessionsDeviceEntity {
  const factory SessionsDeviceEntity({
    required int id,
    required String deviceName,
    required DateTime lastUsedAt,
    required DateTime expiresAt,
  }) = _SessionsDeviceEntity;
}
