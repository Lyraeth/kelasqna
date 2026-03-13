import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<PaginatedResult<QuestionEntity>>> fetchBookmarkedUserQuestion({
    int page = 1,
  }) async {
    final response = await _remoteDataSource.fetchBookmarkedUserQuestion(
      page: page,
    );

    return response.match((failure) => Left(failure), (
      ProfileQuestionsResponse profileQuestionsResponse,
    ) {
      final meta = profileQuestionsResponse.metaProfile;

      final totalPages = meta.lastPage;

      return Right(
        PaginatedResult(
          data: profileQuestionsResponse.listQuestion
              .map((m) => m.toEntity())
              .toList(),
          currentPage: meta.currentPage,
          totalPages: totalPages,
        ),
      );
    });
  }

  @override
  Future<Result<PaginatedResult<CommentsEntity>>> fetchCommentedUserQuestion({
    int page = 1,
  }) async {
    final response = await _remoteDataSource.fetchCommentedUserQuestion(
      page: page,
    );

    return response.match((failure) => Left(failure), (
      CommentedQuestionsResponse commentedQuestionsResponse,
    ) {
      final meta = commentedQuestionsResponse.metaProfile;

      final totalPages = meta.lastPage;

      return Right(
        PaginatedResult(
          data: commentedQuestionsResponse.listComment
              .map((m) => m.toEntity())
              .toList(),
          currentPage: meta.currentPage,
          totalPages: totalPages,
        ),
      );
    });
  }

  @override
  Future<Result<PaginatedResult<QuestionEntity>>> fetchCreatedUserQuestion({
    int? userId,
    int page = 1,
  }) async {
    final response = await _remoteDataSource.fetchCreatedUserQuestion(
      userId: userId,
      page: page,
    );

    return response.match((failure) => Left(failure), (
      ProfileQuestionsResponse profileQuestionsResponse,
    ) {
      final meta = profileQuestionsResponse.metaProfile;

      final totalPages = meta.lastPage;

      return Right(
        PaginatedResult(
          data: profileQuestionsResponse.listQuestion
              .map((m) => m.toEntity())
              .toList(),
          currentPage: meta.currentPage,
          totalPages: totalPages,
        ),
      );
    });
  }
}
