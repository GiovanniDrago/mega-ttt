import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it')
  ];

  /// No description provided for @checkForUpdates.
  ///
  /// In en, this message translates to:
  /// **'Check for updates'**
  String get checkForUpdates;

  /// No description provided for @updateAvailable.
  ///
  /// In en, this message translates to:
  /// **'Update available'**
  String get updateAvailable;

  /// No description provided for @noUpdates.
  ///
  /// In en, this message translates to:
  /// **'No updates available'**
  String get noUpdates;

  /// No description provided for @updateError.
  ///
  /// In en, this message translates to:
  /// **'Could not check for updates'**
  String get updateError;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @closeButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButton;

  /// No description provided for @aboutMenuItem.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutMenuItem;

  /// No description provided for @aboutDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutDialogTitle;

  /// No description provided for @aboutDialogGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hi.'**
  String get aboutDialogGreeting;

  /// No description provided for @aboutDirectMessage.
  ///
  /// In en, this message translates to:
  /// **'I hope you\'re enjoying the app. If it made you smile and you want to support it, you can leave a small tip.'**
  String get aboutDirectMessage;

  /// No description provided for @aboutPlayMessage.
  ///
  /// In en, this message translates to:
  /// **'I hope you\'re enjoying the app. If you want to know more about the project, check the repository page.'**
  String get aboutPlayMessage;

  /// No description provided for @aboutDonationButton.
  ///
  /// In en, this message translates to:
  /// **'Buy me a coffee'**
  String get aboutDonationButton;

  /// No description provided for @aboutGithubButton.
  ///
  /// In en, this message translates to:
  /// **'Open GitHub repo'**
  String get aboutGithubButton;

  /// No description provided for @externalLinkError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the link.'**
  String get externalLinkError;

  /// No description provided for @newGame.
  ///
  /// In en, this message translates to:
  /// **'New Game'**
  String get newGame;

  /// No description provided for @leaderboard.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get leaderboard;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @themes.
  ///
  /// In en, this message translates to:
  /// **'Themes'**
  String get themes;

  /// No description provided for @players.
  ///
  /// In en, this message translates to:
  /// **'Players'**
  String get players;

  /// No description provided for @managePlayers.
  ///
  /// In en, this message translates to:
  /// **'Manage Players'**
  String get managePlayers;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @versionFormat.
  ///
  /// In en, this message translates to:
  /// **'v{version}'**
  String versionFormat(String version);

  /// No description provided for @needTwoActivePlayers.
  ///
  /// In en, this message translates to:
  /// **'Set 2 active players in Settings before starting a game.'**
  String get needTwoActivePlayers;

  /// No description provided for @gameDraw.
  ///
  /// In en, this message translates to:
  /// **'It\'s a draw!'**
  String get gameDraw;

  /// No description provided for @gameWin.
  ///
  /// In en, this message translates to:
  /// **'{name} ({symbol}) wins!'**
  String gameWin(String name, String symbol);

  /// No description provided for @statusViewing.
  ///
  /// In en, this message translates to:
  /// **'{name} ({symbol}) — viewing'**
  String statusViewing(String name, String symbol);

  /// No description provided for @statusPlaceMark.
  ///
  /// In en, this message translates to:
  /// **'{name} ({symbol}) — place your mark'**
  String statusPlaceMark(String name, String symbol);

  /// No description provided for @statusPlayHighlighted.
  ///
  /// In en, this message translates to:
  /// **'{name} ({symbol}) — play in highlighted sector'**
  String statusPlayHighlighted(String name, String symbol);

  /// No description provided for @statusChooseSector.
  ///
  /// In en, this message translates to:
  /// **'{name} ({symbol}) — choose a sector'**
  String statusChooseSector(String name, String symbol);

  /// No description provided for @resetGame.
  ///
  /// In en, this message translates to:
  /// **'Reset Game'**
  String get resetGame;

  /// No description provided for @sectorTitle.
  ///
  /// In en, this message translates to:
  /// **'Sector {n}'**
  String sectorTitle(int n);

  /// No description provided for @noPlayersYet.
  ///
  /// In en, this message translates to:
  /// **'No players yet'**
  String get noPlayersYet;

  /// No description provided for @wins.
  ///
  /// In en, this message translates to:
  /// **'Wins'**
  String get wins;

  /// No description provided for @losses.
  ///
  /// In en, this message translates to:
  /// **'Losses'**
  String get losses;

  /// No description provided for @draws.
  ///
  /// In en, this message translates to:
  /// **'Draws'**
  String get draws;

  /// No description provided for @resetLeaderboard.
  ///
  /// In en, this message translates to:
  /// **'Reset Leaderboard'**
  String get resetLeaderboard;

  /// No description provided for @addPlayer.
  ///
  /// In en, this message translates to:
  /// **'Add Player'**
  String get addPlayer;

  /// No description provided for @resetLeaderboardConfirm.
  ///
  /// In en, this message translates to:
  /// **'This will reset all wins, losses and draws for every player. Continue?'**
  String get resetLeaderboardConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @newPlayer.
  ///
  /// In en, this message translates to:
  /// **'New Player'**
  String get newPlayer;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter name'**
  String get enterName;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @editName.
  ///
  /// In en, this message translates to:
  /// **'Edit Name'**
  String get editName;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @deletePlayer.
  ///
  /// In en, this message translates to:
  /// **'Delete Player'**
  String get deletePlayer;

  /// No description provided for @deletePlayerConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"?'**
  String deletePlayerConfirm(String name);

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @themeDarkNavy.
  ///
  /// In en, this message translates to:
  /// **'Dark Navy'**
  String get themeDarkNavy;

  /// No description provided for @themeMidnightPurple.
  ///
  /// In en, this message translates to:
  /// **'Midnight Purple'**
  String get themeMidnightPurple;

  /// No description provided for @themeForest.
  ///
  /// In en, this message translates to:
  /// **'Forest'**
  String get themeForest;

  /// No description provided for @themeOcean.
  ///
  /// In en, this message translates to:
  /// **'Ocean'**
  String get themeOcean;

  /// No description provided for @themeSunset.
  ///
  /// In en, this message translates to:
  /// **'Sunset'**
  String get themeSunset;

  /// No description provided for @themeLightClassic.
  ///
  /// In en, this message translates to:
  /// **'Light Classic'**
  String get themeLightClassic;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageItalian.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get languageItalian;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
