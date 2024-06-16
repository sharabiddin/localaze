import 'package:localaze/src/translations_structure_enum.dart';

import 'translations_config.dart';

/// The default configuration that will be used to translate the keys if no configuration is provided
class DefaultConfig extends TranslationsConfig {
  DefaultConfig({
    String? absentValue,
    RegExp? paramPattern,
    Set<String>? supportedLanguages,
    String? defaultLanguage,
    Map<String, Map<String, String>>? translations,
    TranslationsStructureEnum? translationsStructure,
    String? absentKey,
  }) : super(
          absentValue: absentValue ?? '??',
          paramPattern: paramPattern ?? RegExp(r'{(\w+)}'),
          supportedLanguages: supportedLanguages ?? {'en'},
          defaultLanguage: defaultLanguage ?? 'en',
          translations: translations ?? {},
          absentKey: absentKey ?? 'TODO: ADD KEY - KEY DOES NOT EXISTS',
          translationsStructure: translationsStructure ?? TranslationsStructureEnum.keyFirst,
        );

  @override
  TranslationsConfig copyWith(
          {String? absentValue,
          RegExp? paramPattern,
          Set<String>? supportedLanguages,
          String? defaultLanguage,
          Map<String, Map<String, String>>? translations,
          TranslationsStructureEnum? translationsStructure,
          String? absentKey}) =>
      DefaultConfig(
        absentValue: absentValue ?? this.absentValue,
        paramPattern: paramPattern ?? this.paramPattern,
        supportedLanguages: supportedLanguages ?? this.supportedLanguages,
        defaultLanguage: defaultLanguage ?? this.defaultLanguage,
        translations: translations ?? this.translations,
        translationsStructure: translationsStructure ?? this.translationsStructure,
        absentKey: absentKey ?? this.absentKey,
      );
}
