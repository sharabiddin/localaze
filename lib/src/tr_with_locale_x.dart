import 'package:flutter/widgets.dart';
import 'localaze.dart';
import 'mod.dart';

/// Extension on [String] that provides translation functionality with BuildContext support.
/// This extension automatically gets the current locale from the context.
/// 
/// Example:
/// ```dart
/// // Simple translation using context
/// Text('greeting'.trWithLocale(context));
/// 
/// // Translation with parameters
/// Text('welcome_message'.trWithLocale(
///   context,
///   param1: ParamModel(key: 'name', value: 'John')
/// ));
/// 
/// // Multiple parameters
/// Text('formal_greeting'.trWithLocale(
///   context,
///   param1: ParamModel(key: 'title', value: 'Mr.'),
///   param2: ParamModel(key: 'name', value: 'John')
/// ));
/// ```
extension TrWithLocaleX on String {
  /// Translates the string using the locale from the provided context.
  /// 
  /// Parameters:
  /// - [context]: The BuildContext to get the current locale from
  /// - [param1], [param2], [param3]: Optional named parameters to replace in the translation
  /// 
  /// Returns the translated string with all parameters replaced.
  /// If the translation key doesn't exist, returns the configured absent key message.
  String trWithLocale(
    BuildContext context, {
    ParamModel? param1,
    ParamModel? param2,
    ParamModel? param3,
  }) {
    final locale = Localaze.of(context).currentLocale;
    return Translator.translate(this, locale.languageCode, param1, param2, param3);
  }
} 