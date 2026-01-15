import 'package:kelasqna/core/internationalization/data/datasources/intl_local_data_source.dart';
import 'package:kelasqna/core/internationalization/domain/repository/intl_repository.dart';

class IntlRepositoryImpl implements IntlRepository {
  final IntlLocalDataSource _localDataSource;

  IntlRepositoryImpl(this._localDataSource);

  @override
  String getCurrentLanguageCode() => _localDataSource.getCurrentLanguageCode();

  @override
  Future<void> setCurrentLanguageCode(String value) async =>
      _localDataSource.setCurrentLanguageCode(value);
}
