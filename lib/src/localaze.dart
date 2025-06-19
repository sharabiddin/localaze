import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '_default_config.dart';
import 'mod.dart';

/// Main class for managing translations in Flutter applications.
/// This class provides access to translations and handles locale changes.
class Localaze extends ChangeNotifier {
  static const String _localeKey = 'localaze_current_locale';

  /// Singleton instance
  static final Localaze instance = Localaze._();

  /// Private constructor
  Localaze._();

  /// The current configuration
  TranslationsConfig config = DefaultConfig();

  /// Current locale of the app
  Locale? _currentLocale;

  /// Internal counter to track translation updates
  int _translationsVersion = 0;

  /// Get the current translations version
  int get translationsVersion => _translationsVersion;

  /// Get the current locale
  Locale get currentLocale => _currentLocale ?? Locale(config.defaultLanguage);

  /// Get all supported locales for MaterialApp configuration
  List<Locale> get supportedLocales =>
      config.supportedLanguages.map((lang) => Locale(lang)).toList();

  /// Get Localaze instance from BuildContext
  static Localaze of(BuildContext context) {
    return Localizations.of<Localaze>(context, Localaze)!;
  }

  /// Initialize Localaze with configuration and restore saved locale
  static Future<void> init({TranslationsConfig? config}) async {
    if (config != null) {
      instance.config = config;
    }

    // Always sync Translator config with instance config
    Translator.config = instance.config;

    final prefs = await SharedPreferences.getInstance();
    final savedLocale = prefs.getString(_localeKey);

    if (savedLocale != null &&
        instance.config.supportedLanguages.contains(savedLocale)) {
      instance._currentLocale = Locale(savedLocale);
    } else {
      instance._currentLocale = Locale(instance.config.defaultLanguage);
    }

    instance.notifyListeners();
  }

  /// Set the current locale and notify listeners
  Future<void> setLocale(Locale locale) async {
    if (!config.supportedLanguages.contains(locale.languageCode)) {
      locale = Locale(config.defaultLanguage);
    }

    if (_currentLocale == locale) return;

    _currentLocale = locale;
    await _saveLocale(locale.languageCode);
    notifyListeners();
  }

  /// Save the current locale to persistent storage
  Future<void> _saveLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, languageCode);
  }

  /// Translate a key with the current locale
  String translate(
    String key, [
    ParamModel? param1,
    ParamModel? param2,
    ParamModel? param3,
  ]) {
    return Translator.translate(
      key,
      currentLocale.languageCode,
      param1,
      param2,
      param3,
    );
  }

  /// Update the configuration
  void updateConfig(TranslationsConfig newConfig) {
    config = newConfig;
    // Update Translator config to match
    Translator.config = newConfig;
    _translationsVersion++; // Increment version on config update
    notifyListeners();
  }

  /// Update translations while preserving other configuration settings
  ///
  /// This method allows you to update translations dynamically without changing
  /// other configuration parameters like supported languages, default language,
  /// or parameter patterns.
  ///
  /// The [newTranslations] map should follow the same structure as defined in
  /// [TranslationsConfig.translationsStructure].
  ///
  /// Example:
  /// ```dart
  /// Localaze.instance.updateTranslations({
  ///   'en': {
  ///     'welcome': 'Welcome!',
  ///     'hello': 'Hello {name}!'
  ///   },
  ///   'es': {
  ///     'welcome': '¡Bienvenido!',
  ///     'hello': '¡Hola {name}!'
  ///   }
  /// });
  /// ```
  void updateTranslations(Map<String, Map<String, String>> newTranslations) {
    print('Updating translations in Localaze instance...');
    // Create a new config with updated translations
    final newConfig = config.copyWith(translations: newTranslations);
    config = newConfig;
    // Update Translator config to match
    Translator.config = newConfig;
    _translationsVersion++; // Increment version on translations update
    print('Translations updated, notifying listeners...');
    notifyListeners();
    print('Listeners notified');
  }
}
