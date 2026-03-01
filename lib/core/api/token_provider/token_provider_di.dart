part of 'token_provider.dart';

void initTokenDI() {
  sI.registerLazySingleton<TokenProvider>(
    () => TokenProviderImpl(sI<SessionsLocalDataSource>()),
  );
}
