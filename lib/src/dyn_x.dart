import 'mod.dart';

/// Extension on [String] that provides dynamic parameter replacement functionality.
/// This extension allows you to replace placeholders in a string with values
/// without performing translation.
/// 
/// Supports up to 3 dynamic parameters that can be replaced in the string.
/// The string should contain placeholders in the format {paramName} that will
/// be replaced with the corresponding parameter values.
/// 
/// Example:
/// ```dart
/// // Text with placeholders: "Hello {name}!"
/// final text = "Hello {name}!";
/// 
/// // Simple parameter replacement
/// text.dyn(ParamModel(key: 'name', value: 'John')); 
/// // Output: 'Hello John!'
/// 
/// // Multiple parameter replacement
/// "Welcome {title} {name}!".dyn(
///   ParamModel(key: 'title', value: 'Mr.'),
///   ParamModel(key: 'name', value: 'John')
/// ); // Output: 'Welcome Mr. John!'
/// 
/// // Missing parameter
/// "Hello {name}!".dyn(); // Output: 'Hello ??!'
/// ```
/// 
/// Todo(Sharaf): Add more parameters constructor
extension DynX on String {
  /// Replaces parameter placeholders in the string with provided values.
  /// Unlike [TrX.tr], this method works directly on the string content
  /// without looking up translations.
  /// 
  /// Parameters:
  /// - [param1], [param2], [param3]: Optional parameters to replace placeholders.
  ///   Each parameter must be a [ParamModel] instance with matching key and value.
  /// 
  /// Returns the string with all matched parameters replaced.
  /// If a parameter is not provided for a placeholder, returns the configured absent value.
  String dyn([
    ParamModel? param1,
    ParamModel? param2,
    ParamModel? param3,
  ]) =>
      Translator.dynamize(this, param1, param2, param3);
}
