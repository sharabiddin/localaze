# Localaze

A powerful and flexible localization package for Flutter/Dart applications that provides runtime translation capabilities with support for dynamic parameters.

## Features

- 🌍 Runtime localization support
- 🔄 Dynamic parameter substitution
- 🎯 Type-safe parameter handling
- 📱 Flutter integration with MaterialApp
- ⚡ Real-time translation updates
- 💾 Persistent locale storage

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  localaze: ^latest_version
```

## How to Use

### 1. Import Required Packages

```dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localaze/localaze.dart';
```

### 2. Initialize Localaze

Initialize Localaze in your app's startup (typically in `main.dart`):

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Localaze.init(
    config: DefaultConfig(
      translations: {
        'en': {
          'welcome': 'Welcome to Localaze!',
          'hello_name': 'Hello, {name}!',
          'items_count': 'You have {count} items',
          'profile.title': 'Profile',
          'profile.settings': 'Settings',
          'profile.language': 'Language',
          'current_date': 'Current date: {date}',
        },
        'es': {
          'welcome': '¡Bienvenido a Localaze!',
          'hello_name': '¡Hola, {name}!',
          'items_count': 'Tienes {count} artículos',
          'profile.title': 'Perfil',
          'profile.settings': 'Ajustes',
          'profile.language': 'Idioma',
          'current_date': 'Fecha actual: {date}',
        },
        'fr': {
          'welcome': 'Bienvenue à Localaze!',
          'hello_name': 'Bonjour, {name}!',
          'items_count': 'Vous avez {count} articles',
          'profile.title': 'Profil',
          'profile.settings': 'Paramètres',
          'profile.language': 'Langue',
          'current_date': 'Date actuelle: {date}',
        },
      },
      supportedLanguages: {'en', 'es', 'fr'},
      defaultLanguage: 'en',
      translationsStructure: TranslationsStructureEnum.languageCodeFirst,
      paramPattern: RegExp(r'{(\w+)}'),
      absentKey: 'Translation not found',
      absentValue: 'Value not found',
    ),
  );

  runApp(const MyApp());
}
```

### 3. Setup MaterialApp with Localaze

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Localaze.instance,
      builder: (context, _) {
        return MaterialApp(
          title: 'Localaze Demo',
          locale: Localaze.instance.currentLocale,
          supportedLocales: Localaze.instance.config.supportedLocales,
          localizationsDelegates: [
            LocalazeDelegate(useDeviceLocale: false), // Use default locale instead of device locale
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(),
        );
      },
    );
  }
}
```

### 4. Using Translations in Widgets

You can create helper functions for your parameters to make them more reusable and type-safe:

```dart
// Define parameter helper functions
ParamModel name(String value) => ParamModel(key: 'name', value: value);
ParamModel count(int value) => ParamModel(key: 'count', value: value.toString());
ParamModel date(DateTime value) => ParamModel(
  key: 'date',
  value: value.toLocal().toString().split(' ')[0],
);

// Then use them in your translations
Text(localaze.translate('hello_name', name('John')));
Text(localaze.translate('items_count', count(5)));
Text(localaze.translate('current_date', date(DateTime.now())));
```

Here's a complete widget example:

```dart
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final localaze = Localaze.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localaze.translate('profile.title')),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            onSelected: (String langCode) {
              Localaze.instance.setLocale(Locale(langCode));
            },
            itemBuilder: (BuildContext context) {
              return Localaze.instance.config.supportedLanguages.map((String langCode) {
                return PopupMenuItem<String>(
                  value: langCode,
                  child: Text(langCode.toUpperCase()),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Basic translation
          Text(
            localaze.translate('welcome'),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          
          // Translation with single parameter
          Text(
            localaze.translate(
              'hello_name',
              name('John'),
            ),
          ),
          
          // Translation with number parameter
          Text(
            localaze.translate(
              'items_count',
              count(5),
            ),
          ),
          
          // Translation with date parameter
          Text(
            localaze.translate(
              'current_date',
              date(currentDate),
            ),
          ),
        ],
      ),
    );
  }
}
```

### 5. Dynamic Translation Updates

You can update translations at runtime:

```dart
void updateTranslationsToDemo() {
  developer.log('Updating translations...', name: 'localaze.demo');
  Localaze.instance.updateTranslations({
    'en': {
      'welcome': 'Welcome to the Localaze Demo!',
      'hello_name': 'Hello, {name}! Enjoy using Localaze.',
      // ... other translations
    },
    'es': {
      'welcome': '¡Bienvenido a la demostración de Localaze!',
      'hello_name': '¡Hola, {name}! Disfruta usando Localaze.',
      // ... other translations
    },
    'fr': {
      'welcome': 'Bienvenue dans la démo de Localaze!',
      'hello_name': 'Bonjour, {name}! Profitez de l\'utilisation de Localaze.',
      // ... other translations
    },
  });
}
```

## Example

Check out the [example](example) folder for a complete working demo of the package.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
