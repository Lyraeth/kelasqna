import 'package:kelasqna/kelasqna.dart';

extension CommentsModelMapper on CommentsModel {
  CommentsEntity toEntity() => CommentsEntity(
    id: id,
    content: content,
    createdAt: createdAt,
    author: author,
  );
}
