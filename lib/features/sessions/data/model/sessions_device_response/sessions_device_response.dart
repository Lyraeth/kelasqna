import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'sessions_device_response.freezed.dart';
part 'sessions_device_response.g.dart';

@freezed
abstract class SessionsDeviceResponse with _$SessionsDeviceResponse {
  const factory SessionsDeviceResponse({
    @JsonKey(name: "devices")
    required List<SessionsDeviceModel> listSessionsDevice,
  }) = _SessionsDeviceResponse;

  factory SessionsDeviceResponse.fromJson(Map<String, dynamic> json) =>
      _$SessionsDeviceResponseFromJson(json);
}
