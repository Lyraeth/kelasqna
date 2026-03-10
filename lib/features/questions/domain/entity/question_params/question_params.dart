import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_params.freezed.dart';

@freezed
abstract class QuestionParams with _$QuestionParams {
  const factory QuestionParams({
    required String title,
    required String content,
  }) = _QuestionParams;
}
