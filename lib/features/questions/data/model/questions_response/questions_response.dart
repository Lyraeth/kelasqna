import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'questions_response.freezed.dart';
part 'questions_response.g.dart';

@freezed
abstract class QuestionsResponse with _$QuestionsResponse {
  const factory QuestionsResponse({
    @JsonKey(name: "data") required List<QuestionModel> listQuestion,
    @JsonKey(name: "links") required Links links,
    @JsonKey(name: "meta") required Meta meta,
  }) = _QuestionsResponse;

  factory QuestionsResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestionsResponseFromJson(json);
}
