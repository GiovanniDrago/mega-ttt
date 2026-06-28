// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get checkForUpdates => 'Check for updates';

  @override
  String get updateAvailable => 'Update available';

  @override
  String get noUpdates => 'No updates available';

  @override
  String get updateError => 'Could not check for updates';

  @override
  String get download => 'Download';

  @override
  String get later => 'Later';

  @override
  String get version => 'Version';
}
