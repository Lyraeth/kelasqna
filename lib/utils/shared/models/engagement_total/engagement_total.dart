import 'package:freezed_annotation/freezed_annotation.dart';

part 'engagement_total.freezed.dart';
part 'engagement_total.g.dart';

@freezed
abstract class EngagementTotal with _$EngagementTotal {
  const factory EngagementTotal({
    @JsonKey(name: "likes_count") required int totalLikes,
    @JsonKey(name: "comments_count") required int totalComments,
    @JsonKey(name: "bookmarks_count") required int totalBookmarks,
  }) = _EngagementTotal;

  factory EngagementTotal.fromJson(Map<String, dynamic> json) =>
      _$EngagementTotalFromJson(json);
}
