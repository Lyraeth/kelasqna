import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'commented_questions_response.freezed.dart';
part 'commented_questions_response.g.dart';

@freezed
abstract class CommentedQuestionsResponse with _$CommentedQuestionsResponse {
  const factory CommentedQuestionsResponse({
    required bool error,
    @JsonKey(name: "data") required List<CommentsModel> listComment,
    @JsonKey(name: "meta") required MetaProfile metaProfile,
  }) = _CommentedQuestionsResponse;

  factory CommentedQuestionsResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentedQuestionsResponseFromJson(json);
}
