import 'package:shared_preferences/shared_preferences.dart';

class LanguageStorage {
  final SharedPreferences _prefs;

  LanguageStorage(this._prefs);

  static const _key = 'language_code';

  Future<void> save(String code) async {
    await _prefs.setString(_key, code);
  }

  Future<String?> get() async {
    return _prefs.getString(_key);
  }
}
