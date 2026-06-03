import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game/tic_tac_toe_game.dart';
import 'models/game_theme.dart';
import 'services/theme_service.dart';
import 'services/update_service.dart';

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

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final theme = await ThemeService.load();
    if (mounted) setState(() => _theme = theme);
  }

  void setTheme(GameTheme theme) {
    setState(() => _theme = theme);
    ThemeService.save(theme);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mega TTT',
      debugShowCheckedModeBanner: false,
      theme: _theme.toThemeData(),
      home: GameScreen(theme: _theme, onThemeChanged: setTheme),
    );
  }
}

class GameScreen extends StatefulWidget {
  final GameTheme theme;
  final ValueChanged<GameTheme> onThemeChanged;

  const GameScreen({super.key, required this.theme, required this.onThemeChanged});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late TicTacToeGame _game;
  String _version = '';

  @override
  void initState() {
    super.initState();
    _createGame();
    _loadVersion();
  }

  @override
  void didUpdateWidget(covariant GameScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.theme != widget.theme) {
      _createGame();
    }
  }

  void _createGame() {
    _game = TicTacToeGame(
      theme: widget.theme,
      onStateChanged: () {
        if (mounted) setState(() {});
      },
    );
  }

  Future<void> _loadVersion() async {
    final version = await UpdateService.currentVersion;
    if (mounted) setState(() => _version = version);
  }

  void _resetGame() {
    setState(_createGame);
  }

  String _statusMessage() {
    if (_game.winner == 'draw') {
      return "It's a draw!";
    } else if (_game.winner != null) {
      return "Player ${_game.winner} wins!";
    } else {
      return "Player ${_game.currentPlayer}'s turn";
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final screenSize = MediaQuery.of(context).size;
    final boardSize = screenSize.width < screenSize.height
        ? screenSize.width * 0.9
        : screenSize.height * 0.7;

    final bool hasWinner = _game.winner != null && _game.winner != 'draw';
    final bool isDraw = _game.winner == 'draw';
    final bool isX = _game.winner == 'X';

    Color statusBg;
    Color statusBorder;
    Color statusTextColor;

    if (isDraw) {
      statusBg = Colors.orange.withOpacity(0.2);
      statusBorder = Colors.orange;
      statusTextColor = Colors.orange;
    } else if (hasWinner) {
      statusBg = isX ? theme.statusXBackground : theme.statusOBackground;
      statusBorder = isX ? theme.statusXBorder : theme.statusOBorder;
      statusTextColor = isX ? theme.xColor : theme.oColor;
    } else {
      statusBg = theme.statusDefaultBg;
      statusBorder = theme.statusDefaultBorder;
      statusTextColor = theme.text;
    }

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.settings, color: theme.text),
            color: theme.surface,
            onSelected: (value) {
              if (value == 'check_updates') {
                UpdateService.check(context, silent: false);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                enabled: false,
                child: Text(
                  _version.isNotEmpty ? 'Version: v$_version' : 'Version: ...',
                  style: TextStyle(
                    color: theme.text.withOpacity(0.6),
                    fontSize: 13,
                  ),
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<String>(
                enabled: false,
                child: Text(
                  'Theme',
                  style: TextStyle(
                    color: theme.text.withOpacity(0.6),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ...GameTheme.themes.map(
                (t) => PopupMenuItem<String>(
                  value: 'theme_${t.name}',
                  onTap: () {
                    Navigator.pop(context);
                    widget.onThemeChanged(t);
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: t.background,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: t.accent, width: 2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        t.name,
                        style: TextStyle(
                          fontWeight: widget.theme == t ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      if (widget.theme == t) const Spacer(),
                      if (widget.theme == t)
                        Icon(Icons.check, size: 18, color: theme.accent),
                    ],
                  ),
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<String>(
                value: 'check_updates',
                child: ListTile(
                  leading: Icon(Icons.system_update, size: 20),
                  title: Text('Check for updates', style: TextStyle(fontSize: 14)),
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Text(
                'Tic Tac Toe',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: theme.title,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: statusBorder, width: 2),
                ),
                child: Text(
                  _statusMessage(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: statusTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: boardSize,
                height: boardSize,
                child: GameWidget(game: _game),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _resetGame,
                icon: Icon(Icons.refresh, size: 24, color: Colors.white),
                label: Text(
                  'Reset Game',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  backgroundColor: theme.buttonBg,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
