import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'localaze.dart';

/// A [LocalizationsDelegate] for Localaze that handles initialization and locale changes.
/// This delegate is responsible for loading and initializing the Localaze instance
/// when the app starts or when the locale changes.
/// 
/// Usage:
/// ```dart
/// MaterialApp(
///   localizationsDelegates: [
///     LocalazeDelegate(),
///     GlobalMaterialLocalizations.delegate,
///     GlobalWidgetsLocalizations.delegate,
///   ],
///   supportedLocales: [
///     Locale('en'),
///     Locale('es'),
///     // Add your supported locales
///   ],
///   // ...
/// )
/// ```
class LocalazeDelegate extends LocalizationsDelegate<Localaze> {
  /// Creates a delegate instance.
  /// 
  /// If [overrideLocale] is provided, it will be used instead of the system locale.
  /// This is useful for testing or forcing a specific locale.
  final Locale? overrideLocale;

  /// Whether to use the device locale as the initial locale.
  /// If false, will use the default locale from [TranslationsConfig].
  final bool useDeviceLocale;

  /// Keep track of the translations version to detect changes
  final int translationsVersion;

  LocalazeDelegate({
    this.overrideLocale,
    this.useDeviceLocale = true,
  }) : translationsVersion = Localaze.instance.translationsVersion;

  @override
  bool isSupported(Locale locale) {
    // Check if the locale's language code is in our supported languages
    return Localaze.instance.config.supportedLanguages.contains(locale.languageCode);
  }

  @override
  Future<Localaze> load(Locale locale) async {
    // Initialize Localaze if not already done
    await Localaze.init();

    // Determine which locale to use
    final localeToUse = overrideLocale ?? (useDeviceLocale ? locale : null);

    if (localeToUse != null) {
      // Set the locale if it's supported
      if (isSupported(localeToUse)) {
        await Localaze.instance.setLocale(localeToUse);
      } else {
        // Fall back to default language if the locale is not supported
        await Localaze.instance.setLocale(Locale(Localaze.instance.config.defaultLanguage));
      }
    }

    return Localaze.instance;
  }

  @override
  bool shouldReload(LocalazeDelegate old) {
    return old.overrideLocale != overrideLocale || 
           old.useDeviceLocale != useDeviceLocale ||
           old.translationsVersion != Localaze.instance.translationsVersion;
  }
} 