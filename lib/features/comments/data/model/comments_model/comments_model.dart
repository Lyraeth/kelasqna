import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kelasqna/kelasqna.dart';

part 'comments_model.freezed.dart';
part 'comments_model.g.dart';

@freezed
abstract class CommentsModel with _$CommentsModel {
  const factory CommentsModel({
    required int id,
    required String content,
    required Author author,
    @JsonKey(name: "created_at") required String createdAt,
  }) = _CommentsModel;

  factory CommentsModel.fromJson(Map<String, dynamic> json) =>
      _$CommentsModelFromJson(json);
}
