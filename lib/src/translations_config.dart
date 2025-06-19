import 'package:flutter/widgets.dart';
import 'package:localaze/src/translations_structure_enum.dart';

/// Abstract class that defines the configuration for translations.
/// This class provides the foundation for how translations are handled,
/// including parameter patterns, supported languages, and translation structure.
///
/// To create a custom configuration, extend this class and implement the [copyWith] method.
/// For default configuration, use [DefaultConfig].
///
/// Example:
/// ```dart
/// class MyConfig extends TranslationsConfig {
///   MyConfig() : super(
///     absentValue: '??',
///     paramPattern: RegExp(r'{(\w+)}'),
///     supportedLanguages: {'en', 'es'},
///     defaultLanguage: 'en',
///     translations: {},
///     translationsStructure: TranslationsStructureEnum.keyFirst,
///     absentKey: 'MISSING_KEY'
///   );
///
///   @override
///   TranslationsConfig copyWith({...}) => MyConfig(...);
/// }
/// ```
abstract class TranslationsConfig {
  /// The value that will be returned if a parameter is not found in the translation.
  /// Default is '??' in [DefaultConfig].
  final String absentValue;

  /// The message that will be returned if a translation key is not found.
  /// This helps identify missing translations during development.
  final String absentKey;

  /// The pattern used to identify dynamic parameters in translation strings.
  /// Default pattern in [DefaultConfig] is `{paramName}`.
  /// 
  /// Example: For the string "hello_{name}", the pattern should match "{name}".
  final RegExp paramPattern;

  /// Set of language codes that your application supports.
  /// Language codes should follow ISO 639-1 format (e.g., 'en', 'es', 'fr').
  final Set<String> supportedLanguages;

  /// The fallback language code used when a requested language is not supported.
  /// Must be one of the codes in [supportedLanguages].
  final String defaultLanguage;

  /// The translation data structure. Format depends on [translationsStructure].
  /// 
  /// For [TranslationsStructureEnum.keyFirst]:
  /// ```dart
  /// {
  ///   'hello': {'en': 'Hello', 'es': 'Hola'},
  ///   'bye': {'en': 'Goodbye', 'es': 'Adiós'}
  /// }
  /// ```
  /// 
  /// For [TranslationsStructureEnum.languageCodeFirst]:
  /// ```dart
  /// {
  ///   'en': {'hello': 'Hello', 'bye': 'Goodbye'},
  ///   'es': {'hello': 'Hola', 'bye': 'Adiós'}
  /// }
  /// ```
  final Map<String, Map<String, String>> translations;

  /// Determines how the [translations] map is structured.
  /// See [TranslationsStructureEnum] for details.
  final TranslationsStructureEnum translationsStructure;

  /// Creates a new translation configuration.
  /// All parameters are required to ensure proper functionality.
  const TranslationsConfig({
    required this.absentValue,
    required this.paramPattern,
    required this.supportedLanguages,
    required this.defaultLanguage,
    required this.translations,
    required this.translationsStructure,
    required this.absentKey,
  });

  /// Creates a copy of this configuration with the specified fields replaced.
  /// Implement this method in your concrete configuration class.
  TranslationsConfig copyWith({
    String? absentValue,
    RegExp? paramPattern,
    Set<String>? supportedLanguages,
    String? defaultLanguage,
    Map<String, Map<String, String>>? translations,
    TranslationsStructureEnum? translationsStructure,
    String? absentKey,
  });

  /// Get all supported locales for MaterialApp configuration
  List<Locale> get supportedLocales => 
      supportedLanguages.map((lang) => Locale(lang)).toList();
}
