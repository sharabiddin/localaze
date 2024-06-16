import 'mod.dart';

/// Extension for String class
/// This extension is used to translate the string
/// Supports 3 parameters
/// Todo(Sharaf): Add more parameters constructor
extension TrX on String {
  String tr(
    String? languageCode, [
    ParamModel? param1,
    ParamModel? param2,
    ParamModel? param3,
  ]) =>
      Translator.translate(this, languageCode, param1, param2, param3);
}
