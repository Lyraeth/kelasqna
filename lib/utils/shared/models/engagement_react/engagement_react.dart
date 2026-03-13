import 'package:freezed_annotation/freezed_annotation.dart';

part 'engagement_react.freezed.dart';
part 'engagement_react.g.dart';

@freezed
abstract class EngagementReact with _$EngagementReact {
  const factory EngagementReact({
    @JsonKey(name: "is_liked") required bool isLiked,
    @JsonKey(name: "is_bookmarked") required bool isBookmarked,
  }) = _EngagementReact;

  factory EngagementReact.fromJson(Map<String, dynamic> json) =>
      _$EngagementReactFromJson(json);
}
