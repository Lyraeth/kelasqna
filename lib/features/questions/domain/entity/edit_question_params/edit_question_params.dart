import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_question_params.freezed.dart';

@freezed
abstract class EditQuestionParams with _$EditQuestionParams {
  const factory EditQuestionParams({String? title, String? content}) =
      _EditQuestionParams;
}
