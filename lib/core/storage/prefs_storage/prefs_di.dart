import 'package:kelasqna/kelasqna.dart';
import 'package:shared_preferences/shared_preferences.dart';

void initPrefsDI() async {
  final prefs = await SharedPreferences.getInstance();

  sI.registerSingleton<SharedPreferences>(prefs);
}
