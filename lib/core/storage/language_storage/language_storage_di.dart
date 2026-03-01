import 'package:kelasqna/kelasqna.dart';

void initLanguageStorageDI() {
  sI.registerLazySingleton(() => LanguageStorage());
}
