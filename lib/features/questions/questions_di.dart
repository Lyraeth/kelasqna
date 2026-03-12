import 'package:kelasqna/kelasqna.dart';

Future<void> initQuestionsDI() async {
  sI.registerLazySingleton<QuestionsRepository>(
    () => QuestionsRepositoryImpl(sI<QuestionsRemoteDataSource>()),
  );

  sI.registerLazySingleton<QuestionsRemoteDataSource>(
    () => QuestionsRemoteDataSourceImpl(sI<ApiClient>()),
  );

  sI.registerLazySingleton<FetchAllQuestionsUseCase>(
    () => FetchAllQuestionsUseCase(sI<QuestionsRepository>()),
  );
  sI.registerLazySingleton<FetchQuestionUseCase>(
    () => FetchQuestionUseCase(sI<QuestionsRepository>()),
  );
  sI.registerLazySingleton<CreateQuestionUseCase>(
    () => CreateQuestionUseCase(sI<QuestionsRepository>()),
  );
  sI.registerLazySingleton<DeleteQuestionUseCase>(
    () => DeleteQuestionUseCase(sI<QuestionsRepository>()),
  );
  sI.registerLazySingleton<EditQuestionUseCase>(
    () => EditQuestionUseCase(sI<QuestionsRepository>()),
  );
  sI.registerLazySingleton<LikeQuestionUseCase>(
    () => LikeQuestionUseCase(sI<QuestionsRepository>()),
  );
  sI.registerLazySingleton<BookmarkQuestionUseCase>(
    () => BookmarkQuestionUseCase(sI<QuestionsRepository>()),
  );

  sI.registerFactory<QuestionsBloc>(
    () => QuestionsBloc(
      sI<FetchAllQuestionsUseCase>(),
      sI<LikeQuestionUseCase>(),
      sI<BookmarkQuestionUseCase>(),
    ),
  );

  sI.registerFactory<QuestionBloc>(
    () => QuestionBloc(sI<FetchQuestionUseCase>()),
  );

  sI.registerFactory<CreateQuestionBloc>(
    () => CreateQuestionBloc(sI<CreateQuestionUseCase>()),
  );

  sI.registerFactory<EditQuestionBloc>(
    () => EditQuestionBloc(sI<EditQuestionUseCase>()),
  );

  sI.registerFactory<DeleteQuestionBloc>(
    () => DeleteQuestionBloc(sI<DeleteQuestionUseCase>()),
  );
}
