import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'question_entity.freezed.dart';

@freezed
abstract class QuestionEntity with _$QuestionEntity {
  const factory QuestionEntity({
    required int id,
    required String title,
    required String content,
    required EngagementTotal engagementTotal,
    required EngagementReact engagementReact,
    required Author author,
    List<CommentsEntity>? listComments,
    required String createdAt,
    required DateTime updatedAt,
  }) = _QuestionEntity;
}
