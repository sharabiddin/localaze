Provides ability to translate Json files to localized texts in a variety of languages.
Run time localization for Flutter|Dart applications.


## How to use:

1. import the package

```dart 
import 'package:localaze/localaze.dart';
```

2. Create a map of localized texts, or use json you fetched from the server.

```dart

final targetMap1 = <String, Map<String, String>>{
  'en': {
    'info_message': 'My name is {name} and I am {age} years old',
  },
  'az': {
    'info_message': 'Mənim adım {name} və mən {age} yaşındayam',
  },
};
```

3. Set configuration and initialize the Localaze instance.
 

```dart
Translator.config = Translator.config.copyWith(
    translations: targetMap1,
    supportedLanguages: {'en', 'az'},
    translationsStructure: TranslationsStructureEnum.languageCodeFirst,
  );
```
4. Set params for dynamic translations.

```dart
ParamModel name(String value) => ParamModel(key: 'name', value: value);

ParamModel age(int value) => ParamModel(key: 'age', value: "$value");
```

5. Use the `tr` extension method to get the localized text.

```dart
print(Translator.translate('welcome_message', 'az', name('John'), age(23)));
```
