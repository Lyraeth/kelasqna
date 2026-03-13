import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'me_response.freezed.dart';
part 'me_response.g.dart';

@freezed
abstract class MeResponse with _$MeResponse {
  const factory MeResponse({
    required bool error,
    @JsonKey(name: "user") required UserModel user,
  }) = _MeResponse;

  factory MeResponse.fromJson(Map<String, dynamic> json) =>
      _$MeResponseFromJson(json);
}
