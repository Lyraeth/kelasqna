import 'package:freezed_annotation/freezed_annotation.dart';

part 'intl_language_entity.freezed.dart';

@freezed
abstract class IntlLanguageEntity with _$IntlLanguageEntity {
  const factory IntlLanguageEntity({
    /// Name of the Languages.
    /// ex: Indonesian, English.
    required String languageName,

    /// Code of the Languages.
    /// ex: "id", "en".
    required String languageCode,
  }) = _IntlLanguageEntity;
}
