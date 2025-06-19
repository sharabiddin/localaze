/// Defines how the translations map is structured in the configuration.
/// This affects how translations are stored and accessed internally.
enum TranslationsStructureEnum {
  /// The translation map is structured with keys as the first level
  /// and language codes as the second level.
  /// 
  /// Example:
  /// ```dart
  /// {
  ///   'welcome_message': {
  ///     'en': 'Welcome!',
  ///     'es': '¡Bienvenido!'
  ///   },
  ///   'goodbye_message': {
  ///     'en': 'Goodbye!',
  ///     'es': '¡Adiós!'
  ///   }
  /// }
  /// ```
  /// 
  /// Best for:
  /// - When you want to keep all translations for a key together
  /// - Easier to spot missing translations for specific keys
  keyFirst,

  /// The translation map is structured with language codes as the first level
  /// and translation keys as the second level.
  /// 
  /// Example:
  /// ```dart
  /// {
  ///   'en': {
  ///     'welcome_message': 'Welcome!',
  ///     'goodbye_message': 'Goodbye!'
  ///   },
  ///   'es': {
  ///     'welcome_message': '¡Bienvenido!',
  ///     'goodbye_message': '¡Adiós!'
  ///   }
  /// }
  /// ```
  /// 
  /// Best for:
  /// - When you want to keep all translations for a language together
  /// - Easier to manage language-specific files
  /// - Better for lazy loading of languages
  languageCodeFirst,
}
