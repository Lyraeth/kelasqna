import 'package:kelasqna/kelasqna.dart';

extension QuestionModelMapper on QuestionModel {
  QuestionEntity toEntity() => QuestionEntity(
    id: id,
    title: title,
    content: content,
    author: author,
    engagementTotal: EngagementTotal(
      totalLikes: totalLikes,
      totalComments: totalComments,
      totalBookmarks: totalBookmarks,
    ),
    engagementReact: EngagementReact(
      isLiked: isLiked,
      isBookmarked: isBookmarked,
    ),
    listComments: listComments?.map((c) => c.toEntity()).toList(),
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension QuestionParamsMapper on QuestionParams {
  QuestionRequest toRequest() =>
      QuestionRequest(title: title, content: content);
}

extension EditQuestionParamsMapper on EditQuestionParams {
  EditQuestionRequest toRequest() =>
      EditQuestionRequest(title: title, content: content);
}
