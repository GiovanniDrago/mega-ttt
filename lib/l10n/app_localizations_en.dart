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

  @override
  String get closeButton => 'Close';

  @override
  String get aboutMenuItem => 'About';

  @override
  String get aboutDialogTitle => 'About';

  @override
  String get aboutDialogGreeting => 'Hi.';

  @override
  String get aboutDirectMessage =>
      'I hope you\'re enjoying the app. If it made you smile and you want to support it, you can leave a small tip.';

  @override
  String get aboutPlayMessage =>
      'I hope you\'re enjoying the app. If you want to know more about the project, check the repository page.';

  @override
  String get aboutDonationButton => 'Buy me a coffee';

  @override
  String get aboutGithubButton => 'Open GitHub repo';

  @override
  String get externalLinkError => 'Couldn\'t open the link.';
}
