import 'package:flutter/cupertino.dart';

import '_default_config.dart';
import 'mod.dart';

/// The class that will be used to translate the keys
class Translator {
  /// The configuration that will be used to translate the keys
  /// You can set the configuration by creating your own [TranslationsConfig] instance or by using the [DefaultConfig] copyWith method
  static TranslationsConfig config = DefaultConfig();

  /// Adds dynamic parameters to the target text, package private method
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

  /// Translates the key to the target language
  /// 1. If the language code is not specified, the default language will be used
  /// 2. If the key is not found, the absent key will be returned
  /// 3. If the language code is not supported, the default language will be used
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

  /// Returns the supported language code respecting the provided language code
  /// note: If the language code is not supported, the default language will be returned

  static String _getSupportedLanguageCode(String? languageCode) {
    if (languageCode == null) {
      return config.defaultLanguage;
    } else {
      return config.supportedLanguages.contains(languageCode) ? languageCode : config.defaultLanguage;
    }
  }
}
