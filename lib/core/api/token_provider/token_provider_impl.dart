part of 'token_provider.dart';

class TokenProviderImpl implements TokenProvider {
  final SessionsLocalDataSource _sessionLocalDataSource;

  String? _cachedToken;

  TokenProviderImpl(this._sessionLocalDataSource);

  @override
  Future<String?> getToken() async {
    return _cachedToken ?? await _sessionLocalDataSource.getAccessToken();
  }

  @override
  void setToken(String token) {
    _cachedToken = token;
  }

  @override
  void clearToken() {
    _cachedToken = null;
  }
}
