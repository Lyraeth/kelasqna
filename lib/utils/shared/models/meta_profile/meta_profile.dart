import 'package:freezed_annotation/freezed_annotation.dart';

part 'meta_profile.freezed.dart';
part 'meta_profile.g.dart';

@freezed
abstract class MetaProfile with _$MetaProfile {
  const factory MetaProfile({
    @JsonKey(name: "current_page") required int currentPage,
    @JsonKey(name: "last_page") required int lastPage,
    required int total,
  }) = _MetaProfile;

  factory MetaProfile.fromJson(Map<String, dynamic> json) =>
      _$MetaProfileFromJson(json);
}
