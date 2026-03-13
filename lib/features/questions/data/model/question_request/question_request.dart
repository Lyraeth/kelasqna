import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_request.freezed.dart';
part 'question_request.g.dart';

@freezed
abstract class QuestionRequest with _$QuestionRequest {
  const factory QuestionRequest({
    required String title,
    required String content,
  }) = _QuestionRequest;

  factory QuestionRequest.fromJson(Map<String, dynamic> json) =>
      _$QuestionRequestFromJson(json);
}
