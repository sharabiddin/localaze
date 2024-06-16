import 'mod.dart';

/// Extension for String class
/// This extension is used to dynamize the string
/// Supports 3 parameters
/// Todo(Sharaf): Add more parameters constructor
extension DynX on String {
  String dyn([
    ParamModel? param1,
    ParamModel? param2,
    ParamModel? param3,
  ]) =>
      Translator.dynamize(this, param1, param2, param3);
}
