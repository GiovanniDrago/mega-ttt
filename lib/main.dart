import 'dart:math';
import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'models/game_theme.dart';
import 'models/player.dart';
import 'services/theme_service.dart';
import 'services/player_service.dart';
import 'services/locale_service.dart';
import 'services/update_service.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static _MyAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MyAppState>();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GameTheme _theme = GameTheme.themes[0];
  List<Player> _players = [];
  List<String> _activePlayerIds = [];
  Locale _locale = const Locale('en');

  GameTheme get theme => _theme;
  List<Player> get players => _players;
  List<String> get activePlayerIds => _activePlayerIds;
  Locale get locale => _locale;

  List<Player> get activePlayers {
    return _players.where((p) => _activePlayerIds.contains(p.id)).toList();
  }

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  Future<void> _loadAll() async {
    final theme = await ThemeService.load();
    final locale = await LocaleService.load();
    final players = await PlayerService.loadAll();
    final activeIds = await PlayerService.getActivePlayerIds();
    if (mounted) {
      setState(() {
        _theme = theme;
        _locale = locale;
        _players = players;
        _activePlayerIds = activeIds;
      });
    }
  }

  void setTheme(GameTheme theme) {
    setState(() => _theme = theme);
    ThemeService.save(theme);
  }

  void setLocale(Locale locale) {
    setState(() => _locale = locale);
    LocaleService.save(locale);
  }

  Future<void> addPlayer(String name) async {
    final player = await PlayerService.addPlayer(name);
    setState(() => _players.add(player));
  }

  Future<void> updatePlayer(String id, String name) async {
    await PlayerService.updatePlayer(id, name);
    setState(() {
      for (final p in _players) {
        if (p.id == id) {
          p.name = name;
          break;
        }
      }
    });
  }

  Future<void> deletePlayer(String id) async {
    await PlayerService.deletePlayer(id);
    setState(() {
      _players.removeWhere((p) => p.id == id);
      _activePlayerIds.remove(id);
    });
  }

  void setActivePlayerIds(List<String> ids) {
    setState(() => _activePlayerIds = ids);
    PlayerService.setActivePlayerIds(ids);
  }

  Future<void> refreshPlayers() async {
    final players = await PlayerService.loadAll();
    final activeIds = await PlayerService.getActivePlayerIds();
    if (mounted) {
      setState(() {
        _players = players;
        _activePlayerIds = activeIds;
      });
    }
  }

  Future<void> resetAllScores() async {
    await PlayerService.resetAllScores();
    await refreshPlayers();
  }

  Map<String, String> assignRandomSymbols() {
    final active = activePlayers;
    final shuffled = List<Player>.from(active)..shuffle(Random());
    final map = <String, String>{};
    for (int i = 0; i < shuffled.length && i < 2; i++) {
      map[i == 0 ? 'X' : 'O'] = shuffled[i].id;
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mega TTT',
      debugShowCheckedModeBanner: false,
      theme: _theme.toThemeData(),
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: _AppStartupWrapper(
        child: HomeScreen(
          theme: _theme,
          onThemeChanged: setTheme,
          players: _players,
          activePlayerIds: _activePlayerIds,
          onPlayersChanged: refreshPlayers,
        ),
      ),
    );
  }
}

class _AppStartupWrapper extends StatefulWidget {
  final Widget child;
  const _AppStartupWrapper({required this.child});

  @override
  State<_AppStartupWrapper> createState() => _AppStartupWrapperState();
}

class _AppStartupWrapperState extends State<_AppStartupWrapper> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UpdateService.check(context, silent: true);
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
