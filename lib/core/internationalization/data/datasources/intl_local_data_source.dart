import 'package:hive/hive.dart';
import 'package:kelasqna/core/storage/hive/hive_storage_label.dart';

abstract class IntlLocalDataSource {
  Future<void> setCurrentLanguageCode(String value);

  String getCurrentLanguageCode();
}

class IntlLocalDataSourceImpl implements IntlLocalDataSource {
  @override
  String getCurrentLanguageCode() =>
      Hive.box(intlBoxKey).get(intlCurrentLanguageCodeKey);

  @override
  Future<void> setCurrentLanguageCode(String value) async =>
      Hive.box(intlBoxKey).put(intlCurrentLanguageCodeKey, value);
}
