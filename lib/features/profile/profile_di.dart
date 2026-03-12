import 'package:kelasqna/kelasqna.dart';

Future<void> initProfileDI() async {
  sI.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sI<ProfileRemoteDataSource>()),
  );

  sI.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sI<ApiClient>()),
  );

  sI.registerLazySingleton<FetchBookmarkedUserQuestionUseCase>(
    () => FetchBookmarkedUserQuestionUseCase(sI<ProfileRepository>()),
  );

  sI.registerLazySingleton<FetchCreatedUserQuestionUseCase>(
    () => FetchCreatedUserQuestionUseCase(sI<ProfileRepository>()),
  );

  sI.registerLazySingleton<FetchCommentedUserQuestionUseCase>(
    () => FetchCommentedUserQuestionUseCase(sI<ProfileRepository>()),
  );

  sI.registerFactory<ProfileCommentsBloc>(
    () => ProfileCommentsBloc(sI<FetchCommentedUserQuestionUseCase>()),
  );

  sI.registerFactory<ProfileQuestionsBloc>(
    () => ProfileQuestionsBloc(sI<FetchCreatedUserQuestionUseCase>()),
  );

  sI.registerFactory<ProfileBookmarksBloc>(
    () => ProfileBookmarksBloc(sI<FetchBookmarkedUserQuestionUseCase>()),
  );
}
