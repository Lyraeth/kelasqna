part of 'token_provider.dart';

Future<void> initTokenDI() async {
  sI.registerLazySingleton<TokenProvider>(
    () => TokenProviderImpl(sI<SessionsLocalDataSource>()),
  );
}
