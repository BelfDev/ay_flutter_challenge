import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  _ContactBookRouteLocalizations get contactRoute =>
      _ContactBookRouteLocalizations(this.locale);

  _SearchRouteLocalizations get searchRoute =>
      _SearchRouteLocalizations(this.locale);

  _ContactDetailRouteLocalizations get detailRoute =>
      _ContactDetailRouteLocalizations(this.locale);
}

class _ContactBookRouteLocalizations {
  final Locale _locale;

  _ContactBookRouteLocalizations(this._locale);

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Contacts',
      'author': 'Author',
    },
    'de': {
      'title': 'Kontakte',
      'author': 'Autor',
    },
    'pt': {
      'title': 'Contatos',
      'author': 'Autor',
    },
    'es': {
      'title': 'Contactos',
      'author': 'Autor',
    }
  };

  String get title => _localizedValues[_locale.languageCode]['title'];

  String get author => _localizedValues[_locale.languageCode]['author'];
}

class _SearchRouteLocalizations {
  final Locale _locale;

  _SearchRouteLocalizations(this._locale);

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {'hint': 'Tap to search contacts', 'instruction': "Type in a name"},
    'de': {
      'hint': 'Tippen Sie suchen',
      'instruction': "Geben Sie einen Kontaktnamen"
    },
    'pt': {
      'hint': 'Toque aqui para pesquisar',
      'instruction': "Digite um nome"
    },
    'es': {'hint': 'Toque aquí para buscar', 'instruction': "Ingrese un nombre"}
  };

  String get hint => _localizedValues[_locale.languageCode]['hint'];

  String get instruction =>
      _localizedValues[_locale.languageCode]['instruction'];
}

class _ContactDetailRouteLocalizations {
  final Locale _locale;

  _ContactDetailRouteLocalizations(this._locale);

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Contact Detail',
    },
    'de': {
      'title': 'Kontaktdetail',
    },
    'pt': {
      'title': 'Detalhe do contato',
    },
    'es': {
      'title': 'Detalles del contacto',
    }
  };

  String get title => _localizedValues[_locale.languageCode]['title'];
}
