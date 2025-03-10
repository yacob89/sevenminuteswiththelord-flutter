import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'Seven Minutes With The Lord',
      'start': 'Start!',
      'goBack': 'Go back',
      'language': 'Language',
      'completed': 'Completed',
      'next': 'Next',
      'allActivitiesCompleted': 'All activities completed',
      'calling': 'Calling',
      'callingDescription': 'Calling on the Name of the Lord to set our mind on the spirit – 1 Cor.12:3; Rom. 8:6; 10:12-13',
      'praying': 'Praying',
      'prayingDescription': 'Opening our heart, softening our heart and emptying ourselves. Telling Him that we love Him – 2 Cor. 3:16; Psa. 62:8',
      'prayReading': 'Pray-reading',
      'prayReadingDescription': 'Using our exercised spirit to pray over a verse or two. Turning the verses into a personal prayer – Eph. 6:17-18; 2 Tim. 3:16',
      'confession': 'Confession',
      'confessionDescription': 'Confessing the sins and offenses on our conscience and removing all blockages to fellowship. Asking for forgiveness and cleansing – 1 John 1:7, 9; Psa. 66:18; Isa. 59:1-2',
      'consecration': 'Consecration',
      'consecrationDescription': 'Presenting ourselves to the Lord afresh, giving Him the full ground in us – Rom. 12:1-2; 6:13,19; Mark 12:30',
      'thanksgiving': 'Thanksgiving',
      'thanksgivingDescription': 'Giving thanks for all things; for all the persons, situations and things in your life and praising Him – Eph. 5:20; 1 Thes. 5:18',
      'petition': 'Petition',
      'petitionDescription': 'Asking the Lord for needs, growth and persons that need salvation – 1 Tim. 2:1: Eph. 6:18; Matt. 7:7; Psa. 143:8',
    },
    'de': {
      'appTitle': 'Sieben Minuten mit dem Herrn',
      'start': 'Start!',
      'goBack': 'Zurück',
      'language': 'Sprache',
      'completed': 'Abgeschlossen',
      'next': 'Nächste',
      'allActivitiesCompleted': 'Alle Aktivitäten abgeschlossen',
      'calling': 'Anrufen',
      'callingDescription': 'Den Namen des Herrn anrufen, um unseren Sinn auf den Geist zu richten – 1 Kor.12:3; Röm. 8:6; 10:12-13',
      'praying': 'Beten',
      'prayingDescription': 'Unser Herz öffnen, unser Herz erweichen und uns selbst entleeren. Ihm sagen, dass wir Ihn lieben – 2 Kor. 3:16; Ps. 62:8',
      'prayReading': 'Bete-lesen',
      'prayReadingDescription': 'Unseren geübten Geist benutzen, um über einen oder zwei Verse zu beten. Die Verse in ein persönliches Gebet verwandeln – Eph. 6:17-18; 2 Tim. 3:16',
      'confession': 'Bekenntnis',
      'confessionDescription': 'Die Sünden und Vergehen auf unserem Gewissen bekennen und alle Blockaden für die Gemeinschaft beseitigen. Um Vergebung und Reinigung bitten – 1 Joh. 1:7, 9; Ps. 66:18; Jes. 59:1-2',
      'consecration': 'Weihe',
      'consecrationDescription': 'Uns dem Herrn neu darbringen und Ihm den vollen Raum in uns geben – Röm. 12:1-2; 6:13,19; Mk. 12:30',
      'thanksgiving': 'Danksagung',
      'thanksgivingDescription': 'Für alles danken; für alle Personen, Situationen und Dinge in Ihrem Leben und Ihn loben – Eph. 5:20; 1 Thes. 5:18',
      'petition': 'Bitte',
      'petitionDescription': 'Den Herrn bitten für Bedürfnisse, Wachstum und Personen, die Errettung benötigen – 1 Tim. 2:1: Eph. 6:18; Matt. 7:7; Ps. 143:8',
    },
    'es': {
      'appTitle': 'Siete Minutos Con El Señor',
      'start': '¡Comenzar!',
      'goBack': 'Regresar',
      'language': 'Idioma',
      'completed': 'Completado',
      'next': 'Siguiente',
      'allActivitiesCompleted': 'Todas las actividades completadas',
      'calling': 'Invocar',
      'callingDescription': 'Invocar el Nombre del Señor para poner nuestra mente en el espíritu – 1 Cor.12:3; Rom. 8:6; 10:12-13',
      'praying': 'Orar',
      'prayingDescription': 'Abrir nuestro corazón, ablandar nuestro corazón y vaciarnos. Decirle que lo amamos – 2 Cor. 3:16; Sal. 62:8',
      'prayReading': 'Ora-leer',
      'prayReadingDescription': 'Usar nuestro espíritu ejercitado para orar sobre un versículo o dos. Convertir los versículos en una oración personal – Ef. 6:17-18; 2 Tim. 3:16',
      'confession': 'Confesión',
      'confessionDescription': 'Confesar los pecados y ofensas en nuestra conciencia y eliminar todos los bloqueos a la comunión. Pedir perdón y limpieza – 1 Juan 1:7, 9; Sal. 66:18; Isa. 59:1-2',
      'consecration': 'Consagración',
      'consecrationDescription': 'Presentarnos al Señor de nuevo, dándole todo el terreno en nosotros – Rom. 12:1-2; 6:13,19; Mar. 12:30',
      'thanksgiving': 'Acción de gracias',
      'thanksgivingDescription': 'Dar gracias por todas las cosas; por todas las personas, situaciones y cosas en tu vida y alabarlo – Ef. 5:20; 1 Tes. 5:18',
      'petition': 'Petición',
      'petitionDescription': 'Pedir al Señor por necesidades, crecimiento y personas que necesitan salvación – 1 Tim. 2:1: Ef. 6:18; Mat. 7:7; Sal. 143:8',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
  
  // Get locale display name
  String getLanguageDisplayName() {
    switch (locale.languageCode) {
      case 'de':
        return 'Deutsch';
      case 'es':
        return 'Español';
      case 'en':
      default:
        return 'English';
    }
  }
  
  // Get all supported languages
  static List<Map<String, String>> getSupportedLanguages() {
    return [
      {'code': 'en', 'name': 'English'},
      {'code': 'de', 'name': 'Deutsch'},
      {'code': 'es', 'name': 'Español'},
    ];
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'de', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return Future.value(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}