// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get checkForUpdates => 'Controlla aggiornamenti';

  @override
  String get updateAvailable => 'Aggiornamento disponibile';

  @override
  String get noUpdates => 'Nessun aggiornamento disponibile';

  @override
  String get updateError => 'Impossibile controllare gli aggiornamenti';

  @override
  String get download => 'Scarica';

  @override
  String get later => 'Più tardi';

  @override
  String get version => 'Versione';
}
