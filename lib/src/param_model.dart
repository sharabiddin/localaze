/// ParamModel class
/// This class is used to define the parameters that will be used in the translation
/// Example: `ParamModel name(String value) => ParamModel(key: 'name', value: value);`
class ParamModel {
  final String key;
  final String value;

  ParamModel({required this.key, required this.value});
}
