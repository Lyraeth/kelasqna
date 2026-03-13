import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

abstract class ProfileRemoteDataSource {
  Future<Result<ProfileQuestionsResponse>> fetchBookmarkedUserQuestion({
    int page = 1,
  });

  Future<Result<ProfileQuestionsResponse>> fetchCreatedUserQuestion({
    int? userId,
    int page = 1,
  });

  Future<Result<CommentedQuestionsResponse>> fetchCommentedUserQuestion({
    int page = 1,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient _apiClient;

  ProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<ProfileQuestionsResponse>> fetchBookmarkedUserQuestion({
    int page = 1,
  }) async {
    try {
      final response = await _apiClient.get(
        "$meUrl/bookmarks",
        queryParameters: {'page': page},
      );

      return response.match(
        (failure) => Left(failure),
        (questionsResponse) =>
            Right(ProfileQuestionsResponse.fromJson(questionsResponse)),
      );
    } catch (e, st) {
      return Left(Failure.fromDio(e, st));
    }
  }

  @override
  Future<Result<CommentedQuestionsResponse>> fetchCommentedUserQuestion({
    int page = 1,
  }) async {
    try {
      final response = await _apiClient.get(
        "$meUrl/comments",
        queryParameters: {'page': page},
      );

      return response.match(
        (failure) => Left(failure),
        (commentsResponse) =>
            Right(CommentedQuestionsResponse.fromJson(commentsResponse)),
      );
    } catch (e, st) {
      return Left(Failure.fromDio(e, st));
    }
  }

  @override
  Future<Result<ProfileQuestionsResponse>> fetchCreatedUserQuestion({
    int? userId,
    int page = 1,
  }) async {
    try {
      final response = await _apiClient.get(
        (userId != null) ? "$userUrl/$userId/questions" : "$meUrl/questions",
        queryParameters: (userId != null) ? null : {'page': page},
      );

      return response.match(
        (failure) => Left(failure),
        (questionsResponse) =>
            Right(ProfileQuestionsResponse.fromJson(questionsResponse)),
      );
    } catch (e, st) {
      return Left(Failure.fromDio(e, st));
    }
  }
}
