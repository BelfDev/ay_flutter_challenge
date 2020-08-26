import 'package:ay_flutter_challenge/configs/app_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'de', 'pt', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture<AppLocalizations>(AppLocalizations(locale));

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;
}
