import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'question_model.freezed.dart';
part 'question_model.g.dart';

@freezed
abstract class QuestionModel with _$QuestionModel {
  const factory QuestionModel({
    required int id,
    required String title,
    required String content,
    @JsonKey(name: "likes_count") required int totalLikes,
    @JsonKey(name: "comments_count") required int totalComments,
    @JsonKey(name: "bookmarks_count") required int totalBookmarks,
    @JsonKey(name: "is_liked") required bool isLiked,
    @JsonKey(name: "is_bookmarked") required bool isBookmarked,
    required Author author,
    @JsonKey(name: "comments") List<CommentsModel>? listComments,
    @JsonKey(name: "created_at") required String createdAt,
    @JsonKey(name: "updated_at") required DateTime updatedAt,
  }) = _QuestionModel;

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);
}
