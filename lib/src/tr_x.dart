import 'mod.dart';

/// Extension on [String] that provides translation functionality.
/// This extension allows you to easily translate strings using the configured translations.
/// 
/// Supports up to 3 dynamic parameters that can be replaced in the translation string.
/// The translation key itself does not contain parameter placeholders - instead,
/// the parameters are defined in the translation value and matched by their keys.
/// 
/// Example:
/// ```dart
/// // Simple translation
/// 'welcome_message'.tr('en'); // Output: 'Welcome!'
/// 
/// // Translation with one parameter
/// // If translation is "Hello {name}!"
/// 'greeting'.tr('en', ParamModel(key: 'name', value: 'John')); 
/// // Output: 'Hello John!'
/// 
/// // Translation with multiple parameters
/// // If translation is "Hello {title} {name}!"
/// 'formal_greeting'.tr('en',
///   ParamModel(key: 'title', value: 'Mr.'),
///   ParamModel(key: 'name', value: 'John')
/// ); // Output: 'Hello Mr. John!'
/// ```
/// 
/// Todo(Sharaf): Add more parameters constructor
extension TrX on String {
  /// Translates the string to the specified language, with optional parameters.
  /// 
  /// Parameters:
  /// - [languageCode]: The target language code (e.g., 'en', 'es'). If null or unsupported,
  ///   falls back to the default language configured in [TranslationsConfig].
  /// - [param1], [param2], [param3]: Optional parameters to replace placeholders in the translation value.
  ///   Each parameter must be a [ParamModel] instance with matching key and value.
  /// 
  /// Returns the translated string with all parameters replaced.
  /// If the translation key doesn't exist, returns the configured absent key message.
  String tr(
    String? languageCode, [
    ParamModel? param1,
    ParamModel? param2,
    ParamModel? param3,
  ]) =>
      Translator.translate(this, languageCode, param1, param2, param3);
}
