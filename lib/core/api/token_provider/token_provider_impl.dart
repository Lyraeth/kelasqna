part of 'token_provider.dart';

class TokenProviderImpl implements TokenProvider {
  final SessionsLocalDataSource _sessionLocalDataSource;

  TokenProviderImpl(this._sessionLocalDataSource);

  @override
  Future<String?> getToken() => _sessionLocalDataSource.getAccessToken();
}
