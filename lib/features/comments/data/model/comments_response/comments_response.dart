import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'comments_response.freezed.dart';
part 'comments_response.g.dart';

@freezed
abstract class CommentsResponse with _$CommentsResponse {
  const factory CommentsResponse({
    @JsonKey(name: "data") required CommentsModel comment,
  }) = _CommentsResponse;

  factory CommentsResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentsResponseFromJson(json);
}
