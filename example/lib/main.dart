import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localaze/localaze.dart';
import 'dart:developer' as developer;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Localaze with configuration
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

// Function to update translations
void updateTranslationsToDemo() {
  developer.log('Updating translations...', name: 'localaze.demo');
  Localaze.instance.updateTranslations({
    'en': {
      'welcome': 'Welcome to the Localaze Demo!',
      'hello_name': 'Hello, {name}! Enjoy using Localaze.',
      'items_count': 'You have {count} items',
      'profile.title': 'Profile',
      'profile.settings': 'Settings',
      'profile.language': 'Language',
      'current_date': 'Current date: {date}',
    },
    'es': {
      'welcome': '¡Bienvenido a la demostración de Localaze!',
      'hello_name': '¡Hola, {name}! Disfruta usando Localaze.',
      'items_count': 'Tienes {count} artículos',
      'profile.title': 'Perfil',
      'profile.settings': 'Ajustes',
      'profile.language': 'Idioma',
      'current_date': 'Fecha actual: {date}',
    },
    'fr': {
      'welcome': 'Bienvenue dans la démo de Localaze!',
      'hello_name': 'Bonjour, {name}! Profitez de l\'utilisation de Localaze.',
      'items_count': 'Vous avez {count} articles',
      'profile.title': 'Profil',
      'profile.settings': 'Paramètres',
      'profile.language': 'Langue',
      'current_date': 'Date actuelle: {date}',
    },
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Localaze.instance,
      builder: (context, _) {
        developer.log(
          'Rebuilding MaterialApp with current locale: ${Localaze.instance.currentLocale.languageCode}',
          name: 'localaze.demo',
        );
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final localaze = Localaze.of(context);

    developer.log(
      'Rebuilding MyHomePage with current locale: ${localaze.currentLocale.languageCode}',
      name: 'localaze.demo',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(localaze.translate('profile.title')),
        actions: [
          // Add update translations button
          IconButton(
            icon: const Icon(Icons.update),
            onPressed: updateTranslationsToDemo,
            tooltip: 'Update Translations',
          ),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localaze.translate('welcome'),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              localaze.translate(
                'hello_name',
                ParamModel(key: 'name', value: 'John'),
              ),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              localaze.translate(
                'items_count',
                ParamModel(key: 'count', value: '5'),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              localaze.translate(
                'current_date',
                ParamModel(
                  key: 'date',
                  value: currentDate.toLocal().toString().split(' ')[0],
                ),
              ),
            ),
            const Divider(height: 32),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(localaze.translate('profile.settings')),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(localaze.translate('profile.language')),
              subtitle: Text(
                localaze.currentLocale.languageCode.toUpperCase(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
