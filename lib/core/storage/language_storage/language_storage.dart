import 'package:kelasqna/kelasqna.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageStorage {
  final SharedPreferences prefs = sI<SharedPreferences>();

  static const _key = 'language_code';

  Future<void> save(String code) async {
    await prefs.setString(_key, code);
  }

  Future<String?> get() async {
    return prefs.getString(_key);
  }
}
