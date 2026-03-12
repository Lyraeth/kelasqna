import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'profile_questions_response.freezed.dart';
part 'profile_questions_response.g.dart';

@freezed
abstract class ProfileQuestionsResponse with _$ProfileQuestionsResponse {
  const factory ProfileQuestionsResponse({
    required bool error,
    @JsonKey(name: "data") required List<QuestionModel> listQuestion,
    @JsonKey(name: "meta") required MetaProfile metaProfile,
  }) = _ProfileQuestionsResponse;

  factory ProfileQuestionsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileQuestionsResponseFromJson(json);
}
