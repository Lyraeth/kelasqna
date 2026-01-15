abstract class IntlRepository {
  Future<void> setCurrentLanguageCode(String value);

  String getCurrentLanguageCode();
}
