import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'comments_entity.freezed.dart';

@freezed
abstract class CommentsEntity with _$CommentsEntity {
  const factory CommentsEntity({
    required int id,
    required String content,
    required Author author,
    required String createdAt,
  }) = _CommentsEntity;
}
