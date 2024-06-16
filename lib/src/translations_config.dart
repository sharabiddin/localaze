import 'package:localaze/src/translations_structure_enum.dart';

abstract class TranslationsConfig {
  /// The value that will be returned if parameter is not specified
  final String absentValue;

  /// The message that will be returned if key is not found
  final String absentKey;

  /// The pattern that will be used to find dynamic parameters in the translation, default is {param}
  final RegExp paramPattern;

  /// The languages that are supported by the application
  final Set<String> supportedLanguages;

  /// The default language that will be used if the language is not specified,
  /// default is 'en' will be returned if code does not contains in [supportedLanguages]
  final String defaultLanguage;

  /// The translations that will be used to translate the keys
  final Map<String, Map<String, String>> translations;

  /// The structure of the translations, default is [TranslationsStructureEnum.keyFirst]
  final TranslationsStructureEnum translationsStructure;

  TranslationsConfig({
    required this.absentValue,
    required this.paramPattern,
    required this.supportedLanguages,
    required this.defaultLanguage,
    required this.translations,
    required this.translationsStructure,
    required this.absentKey,
  });

  TranslationsConfig copyWith({
    String? absentValue,
    RegExp? paramPattern,
    Set<String>? supportedLanguages,
    String? defaultLanguage,
    Map<String, Map<String, String>>? translations,
    TranslationsStructureEnum? translationsStructure,
    String? absentKey,
  });
}
