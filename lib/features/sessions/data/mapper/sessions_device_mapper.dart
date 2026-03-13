import 'package:kelasqna/kelasqna.dart';

extension SessionsDeviceMapper on SessionsDeviceModel {
  SessionsDeviceEntity toEntity() => SessionsDeviceEntity(
    id: id,
    deviceName: deviceName,
    lastUsedAt: lastUsedAt,
    expiresAt: expiresAt,
  );
}
