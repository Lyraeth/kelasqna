import 'package:kelasqna/core/internationalization/domain/repository/intl_repository.dart';

class IntlUseCase {
  final IntlRepository _intlRepository;

  IntlUseCase(this._intlRepository);

  Future<void> setCurrentLanguageCode(String value) =>
      _intlRepository.setCurrentLanguageCode(value);

  String getCurrentLanguageCode() => _intlRepository.getCurrentLanguageCode();
}
