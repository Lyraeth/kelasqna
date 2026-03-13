import 'package:kelasqna/kelasqna.dart';

abstract class ProfileRepository {
  Future<Result<PaginatedResult<QuestionEntity>>> fetchBookmarkedUserQuestion({
    int page = 1,
  });

  Future<Result<PaginatedResult<CommentsEntity>>> fetchCommentedUserQuestion({
    int page = 1,
  });

  Future<Result<PaginatedResult<QuestionEntity>>> fetchCreatedUserQuestion({
    int? userId,
    int page = 1,
  });
}
