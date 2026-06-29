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

  @override
  String get newGame => 'New Game';

  @override
  String get leaderboard => 'Leaderboard';

  @override
  String get settings => 'Settings';

  @override
  String get appearance => 'Appearance';

  @override
  String get themes => 'Themes';

  @override
  String get players => 'Players';

  @override
  String get managePlayers => 'Manage Players';

  @override
  String get loading => 'Loading...';

  @override
  String versionFormat(String version) {
    return 'v$version';
  }

  @override
  String get needTwoActivePlayers =>
      'Set 2 active players in Settings before starting a game.';

  @override
  String get gameDraw => 'It\'s a draw!';

  @override
  String gameWin(String name, String symbol) {
    return '$name ($symbol) wins!';
  }

  @override
  String statusViewing(String name, String symbol) {
    return '$name ($symbol) — viewing';
  }

  @override
  String statusPlaceMark(String name, String symbol) {
    return '$name ($symbol) — place your mark';
  }

  @override
  String statusPlayHighlighted(String name, String symbol) {
    return '$name ($symbol) — play in highlighted sector';
  }

  @override
  String statusChooseSector(String name, String symbol) {
    return '$name ($symbol) — choose a sector';
  }

  @override
  String get resetGame => 'Reset Game';

  @override
  String sectorTitle(int n) {
    return 'Sector $n';
  }

  @override
  String get noPlayersYet => 'No players yet';

  @override
  String get wins => 'Wins';

  @override
  String get losses => 'Losses';

  @override
  String get draws => 'Draws';

  @override
  String get resetLeaderboard => 'Reset Leaderboard';

  @override
  String get addPlayer => 'Add Player';

  @override
  String get resetLeaderboardConfirm =>
      'This will reset all wins, losses and draws for every player. Continue?';

  @override
  String get cancel => 'Cancel';

  @override
  String get reset => 'Reset';

  @override
  String get newPlayer => 'New Player';

  @override
  String get enterName => 'Enter name';

  @override
  String get create => 'Create';

  @override
  String get editName => 'Edit Name';

  @override
  String get save => 'Save';

  @override
  String get deletePlayer => 'Delete Player';

  @override
  String deletePlayerConfirm(String name) {
    return 'Are you sure you want to delete \"$name\"?';
  }

  @override
  String get delete => 'Delete';

  @override
  String get themeDarkNavy => 'Dark Navy';

  @override
  String get themeMidnightPurple => 'Midnight Purple';

  @override
  String get themeForest => 'Forest';

  @override
  String get themeOcean => 'Ocean';

  @override
  String get themeSunset => 'Sunset';

  @override
  String get themeLightClassic => 'Light Classic';

  @override
  String get language => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageItalian => 'Italian';
}
