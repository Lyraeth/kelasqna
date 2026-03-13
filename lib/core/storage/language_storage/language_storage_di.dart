import 'package:kelasqna/kelasqna.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initLanguageStorageDI() async {
  sI.registerLazySingleton(() => LanguageStorage(sI<SharedPreferences>()));
}
