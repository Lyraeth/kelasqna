import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'one_questions_response.freezed.dart';
part 'one_questions_response.g.dart';

@freezed
abstract class OneQuestionsResponse with _$OneQuestionsResponse {
  const factory OneQuestionsResponse({
    @JsonKey(name: "data") required QuestionModel question,
  }) = _OneQuestionsResponse;

  factory OneQuestionsResponse.fromJson(Map<String, dynamic> json) =>
      _$OneQuestionsResponseFromJson(json);
}
