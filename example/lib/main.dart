import 'package:localaze/localaze.dart';

void main() {
  /// Define your translations envelope or get it from the server
  final targetMap1 = <String, Map<String, String>>{
    'en': {
      'welcome_message': 'My name is {name} and I am {age} years old',
    },
    'az': {
      'welcome_message': 'Mənim adım {name} və mən {age} yaşındayam',
    },
  };

  /// Set the configuration
  /// You can set the configuration by creating your own [TranslationsConfig] instance or by using the [DefaultConfig] copyWith method
  Translator.config = Translator.config.copyWith(
    translations: targetMap1,
    supportedLanguages: {'en', 'az'},
    translationsStructure: TranslationsStructureEnum.languageCodeFirst,
  );

  /// Translate the key
  /// Use it on your text widgets
  /// Recommended: Also move the keys to the constants file
  print(Translator.translate('welcome_message', 'az', name('John'), age(23)));
}

/// Define your custom params
ParamModel name(String value) => ParamModel(key: 'name', value: value);

ParamModel age(int value) => ParamModel(key: 'age', value: "$value");
