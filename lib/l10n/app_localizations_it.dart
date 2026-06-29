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

  @override
  String get newGame => 'Nuova partita';

  @override
  String get leaderboard => 'Classifica';

  @override
  String get settings => 'Impostazioni';

  @override
  String get appearance => 'Aspetto';

  @override
  String get themes => 'Temi';

  @override
  String get players => 'Giocatori';

  @override
  String get managePlayers => 'Gestisci giocatori';

  @override
  String get loading => 'Caricamento...';

  @override
  String versionFormat(String version) {
    return 'v$version';
  }

  @override
  String get needTwoActivePlayers =>
      'Imposta 2 giocatori attivi nelle Impostazioni prima di iniziare.';

  @override
  String get gameDraw => 'Pareggio!';

  @override
  String gameWin(String name, String symbol) {
    return '$name ($symbol) vince!';
  }

  @override
  String statusViewing(String name, String symbol) {
    return '$name ($symbol) — osservazione';
  }

  @override
  String statusPlaceMark(String name, String symbol) {
    return '$name ($symbol) — piazza il segno';
  }

  @override
  String statusPlayHighlighted(String name, String symbol) {
    return '$name ($symbol) — gioca nel settore evidenziato';
  }

  @override
  String statusChooseSector(String name, String symbol) {
    return '$name ($symbol) — scegli un settore';
  }

  @override
  String get resetGame => 'Ripristina partita';

  @override
  String sectorTitle(int n) {
    return 'Settore $n';
  }

  @override
  String get noPlayersYet => 'Nessun giocatore';

  @override
  String get wins => 'Vittorie';

  @override
  String get losses => 'Sconfitte';

  @override
  String get draws => 'Pareggi';

  @override
  String get resetLeaderboard => 'Azzera classifica';

  @override
  String get addPlayer => 'Aggiungi giocatore';

  @override
  String get resetLeaderboardConfirm =>
      'Azzererà vittorie, sconfitte e pareggi di tutti. Continuare?';

  @override
  String get cancel => 'Annulla';

  @override
  String get reset => 'Azzera';

  @override
  String get newPlayer => 'Nuovo giocatore';

  @override
  String get enterName => 'Inserisci nome';

  @override
  String get create => 'Crea';

  @override
  String get editName => 'Modifica nome';

  @override
  String get save => 'Salva';

  @override
  String get deletePlayer => 'Elimina giocatore';

  @override
  String deletePlayerConfirm(String name) {
    return 'Eliminare \"$name\"?';
  }

  @override
  String get delete => 'Elimina';

  @override
  String get themeDarkNavy => 'Blu notte';

  @override
  String get themeMidnightPurple => 'Viola notte';

  @override
  String get themeForest => 'Foresta';

  @override
  String get themeOcean => 'Oceano';

  @override
  String get themeSunset => 'Tramonto';

  @override
  String get themeLightClassic => 'Chiaro classico';

  @override
  String get language => 'Lingua';

  @override
  String get languageEnglish => 'Inglese';

  @override
  String get languageItalian => 'Italiano';
}
