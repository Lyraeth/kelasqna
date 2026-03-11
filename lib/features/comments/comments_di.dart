import 'package:kelasqna/kelasqna.dart';

Future<void> initCommentsDI() async {
  sI.registerLazySingleton<CommentsRepository>(
    () => CommentsRepositoryImpl(sI<CommentsRemoteDataSource>()),
  );

  sI.registerLazySingleton<CommentsRemoteDataSource>(
    () => CommentsRemoteDataSourceImpl(sI<ApiClient>()),
  );

  sI.registerLazySingleton<CreateCommentUseCase>(
    () => CreateCommentUseCase(sI<CommentsRepository>()),
  );

  sI.registerLazySingleton<DeleteCommentUseCase>(
    () => DeleteCommentUseCase(sI<CommentsRepository>()),
  );

  sI.registerLazySingleton<EditCommentUseCase>(
    () => EditCommentUseCase(sI<CommentsRepository>()),
  );

  sI.registerFactory<CreateCommentBloc>(
    () => CreateCommentBloc(sI<CreateCommentUseCase>()),
  );

  sI.registerFactory<EditCommentBloc>(
    () => EditCommentBloc(sI<EditCommentUseCase>()),
  );

  sI.registerFactory<DeleteCommentBloc>(
    () => DeleteCommentBloc(sI<DeleteCommentUseCase>()),
  );
}
