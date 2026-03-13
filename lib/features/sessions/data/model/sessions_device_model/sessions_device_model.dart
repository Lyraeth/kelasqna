import 'package:freezed_annotation/freezed_annotation.dart';

part 'sessions_device_model.freezed.dart';
part 'sessions_device_model.g.dart';

@freezed
abstract class SessionsDeviceModel with _$SessionsDeviceModel {
  const factory SessionsDeviceModel({
    required int id,
    @JsonKey(name: "device_name") required String deviceName,
    @JsonKey(name: "last_used_at") required DateTime lastUsedAt,
    @JsonKey(name: "expires_at") required DateTime expiresAt,
  }) = _SessionsDeviceModel;

  factory SessionsDeviceModel.fromJson(Map<String, dynamic> json) =>
      _$SessionsDeviceModelFromJson(json);
}
