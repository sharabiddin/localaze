import 'package:flutter/cupertino.dart';

import '_default_config.dart';
import 'mod.dart';

/// Core translation class that handles string translations and parameter replacement.
/// This class provides static methods for translating strings and replacing dynamic parameters.
/// 
/// The translator uses a configuration ([TranslationsConfig]) that defines:
/// - Supported languages
/// - Default language
/// - Translation structure
/// - Parameter patterns
/// - Fallback values
/// 
/// Example:
/// ```dart
/// // Configure the translator
/// Translator.config = MyConfig();
/// 
/// // Translation setup:
/// // {
/// //   'greeting': {
/// //     'en': 'Hello {name}!',
/// //     'es': '¡Hola {name}!'
/// //   }
/// // }
/// 
/// // Translate a string
/// final translated = Translator.translate(
///   'greeting',
///   'en',
///   ParamModel(key: 'name', value: 'John')
/// );
/// 
/// // Just replace parameters in a string with placeholders
/// final dynamized = Translator.dynamize(
///   'Hello {name}!',
///   ParamModel(key: 'name', value: 'John')
/// );
/// ```
class Translator {
  /// The configuration that will be used for all translations.
  /// You can set this to your own [TranslationsConfig] implementation,
  /// or modify the default one using [DefaultConfig.copyWith].
  /// 
  /// Example:
  /// ```dart
  /// Translator.config = DefaultConfig().copyWith(
  ///   defaultLanguage: 'es',
  ///   supportedLanguages: {'en', 'es', 'fr'},
  /// );
  /// ```
  static TranslationsConfig config = DefaultConfig();

  /// Replaces parameter placeholders in the text with provided values.
  /// This is a low-level method used internally by [translate] and the [DynX] extension.
  /// 
  /// The method searches for patterns matching [TranslationsConfig.paramPattern]
  /// (by default {paramName}) and replaces them with corresponding parameter values.
  /// 
  /// Example:
  /// ```dart
  /// final text = Translator.dynamize(
  ///   'Hello {name}!',
  ///   ParamModel(key: 'name', value: 'John')
  /// ); // Result: 'Hello John!'
  /// ```
  /// 
  /// If a parameter is not provided for a placeholder, returns [TranslationsConfig.absentValue].
  @protected
  static String dynamize(
    String targetText, [
    ParamModel? param1,
    ParamModel? param2,
    ParamModel? param3,
  ]) {
    final Map<String, ParamModel> params = {};
    params.addAll({
      if (param1 != null) param1.key: param1,
      if (param2 != null) param2.key: param2,
      if (param3 != null) param3.key: param3,
    });
    return targetText.replaceAllMapped(
      config.paramPattern,
      (match) {
        final key = match.groupCount > 0 ? match.group(1) : "";
        final param = params[key];
        return param?.value ?? config.absentValue;
      },
    );
  }

  /// Translates a key to the target language and replaces any parameters.
  /// 
  /// The translation process follows these steps:
  /// 1. Validates and resolves the language code
  /// 2. Finds the translation based on [TranslationsConfig.translationsStructure]
  /// 3. Replaces any parameters in the translated string
  /// 
  /// Example:
  /// ```dart
  /// // With translation setup:
  /// // {
  /// //   'formal_greeting': {
  /// //     'en': 'Welcome, {title} {name}!',
  /// //     'es': '¡Bienvenido, {title} {name}!'
  /// //   }
  /// // }
  /// 
  /// final greeting = Translator.translate(
  ///   'formal_greeting',
  ///   'en',
  ///   ParamModel(key: 'title', value: 'Mr.'),
  ///   ParamModel(key: 'name', value: 'John')
  /// ); // Result: 'Welcome, Mr. John!'
  /// ```
  /// 
  /// Parameters:
  /// - [key]: The translation key to look up (e.g., 'formal_greeting')
  /// - [languageCode]: Target language code (falls back to default if null or unsupported)
  /// - [param1], [param2], [param3]: Optional parameters to replace in the translated string
  /// 
  /// Returns the translated string with parameters replaced.
  /// If the key is not found, returns [TranslationsConfig.absentKey].
  static String translate(String key, String? languageCode,
      [ParamModel? param1, ParamModel? param2, ParamModel? param3]) {
    late final String targetText;
    final languageCode0 = _getSupportedLanguageCode(languageCode);
    if (config.translationsStructure == TranslationsStructureEnum.languageCodeFirst) {
      final Map<String, String> translationValues = config.translations[languageCode0] ?? {};
      targetText = translationValues[key] ?? config.absentKey;
    } else {
      final Map<String, String> translation = config.translations[key] ?? {};
      targetText = translation[languageCode0] ?? config.absentKey;
    }
    return dynamize(targetText, param1, param2, param3);
  }

  /// Returns a supported language code based on the provided code.
  /// If the provided code is null or not supported, returns the default language.
  /// 
  /// This is an internal method used by [translate] to ensure a valid language code.
  static String _getSupportedLanguageCode(String? languageCode) {
    if (languageCode == null) {
      return config.defaultLanguage;
    } else {
      return config.supportedLanguages.contains(languageCode) ? languageCode : config.defaultLanguage;
    }
  }
}
