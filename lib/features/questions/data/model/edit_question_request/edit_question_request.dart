import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_question_request.freezed.dart';
part 'edit_question_request.g.dart';

@freezed
abstract class EditQuestionRequest with _$EditQuestionRequest {
  const factory EditQuestionRequest({String? title, String? content}) =
      _EditQuestionRequest;

  factory EditQuestionRequest.fromJson(Map<String, dynamic> json) =>
      _$EditQuestionRequestFromJson(json);
}
