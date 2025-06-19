/// ParamModel class is used to define dynamic parameters for translations.
/// Each parameter has a key that matches the placeholder in the translation string
/// and a value that will replace that placeholder.
///
/// Example:
/// ```dart
/// // For translation string: 'hello_{name}'
/// ParamModel name(String value) => ParamModel(key: 'name', value: value);
/// 
/// // Usage:
/// final param = ParamModel(key: 'name', value: 'John');
/// 'hello_{name}'.tr('en', param); // Output: 'hello_John'
/// ```
class ParamModel {
  /// The key that matches the placeholder in the translation string (e.g., 'name' for '{name}')
  final String key;

  /// The value that will replace the placeholder in the final translation
  final String value;

  /// Creates a parameter model with a key and value.
  /// The [key] should match the placeholder name in your translation string (without braces).
  /// The [value] is what will appear in place of the placeholder in the final translation.
  const ParamModel({required this.key, required this.value});

  @override
  String toString() => 'ParamModel(key: $key, value: $value)';
}
