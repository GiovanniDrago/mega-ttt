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

  @override
  String get closeButton => 'Chiudi';

  @override
  String get aboutMenuItem => 'Info';

  @override
  String get aboutDialogTitle => 'Info';

  @override
  String get aboutDialogGreeting => 'Ciao.';

  @override
  String get aboutDirectMessage =>
      'Spero che l\'app ti stia piacendo. Se ti ha strappato un sorriso e vuoi supportarla, puoi lasciare una piccola mancia.';

  @override
  String get aboutPlayMessage =>
      'Spero che l\'app ti stia piacendo. Se vuoi sapere qualcosa in piu sul progetto, dai un\'occhiata alla pagina del repository.';

  @override
  String get aboutDonationButton => 'Offrimi un caffe';

  @override
  String get aboutGithubButton => 'Apri il repo GitHub';

  @override
  String get externalLinkError => 'Non sono riuscito ad aprire il link.';
}
