import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../game/tic_tac_toe_game.dart';
import '../models/game_theme.dart';

class GameScreen extends StatefulWidget {
  final GameTheme theme;
  final String playerXId;
  final String playerXName;
  final String playerOId;
  final String playerOName;
  final ValueChanged<String>? onGameEnd;

  const GameScreen({
    super.key,
    required this.theme,
    required this.playerXId,
    required this.playerXName,
    required this.playerOId,
    required this.playerOName,
    this.onGameEnd,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late TicTacToeGame _game;
  bool _resultRecorded = false;

  @override
  void initState() {
    super.initState();
    _createGame();
  }

  @override
  void didUpdateWidget(covariant GameScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.theme != widget.theme) {
      _game.updateTheme(widget.theme);
      setState(() {});
    }
  }

  void _createGame() {
    _resultRecorded = false;
    _game = TicTacToeGame(
      theme: widget.theme,
      onStateChanged: () {
        if (mounted) setState(() {});
        if (!_resultRecorded && _game.winner != null) {
          _resultRecorded = true;
          widget.onGameEnd?.call(_game.winner!);
        }
      },
    );
  }

  void _resetGame() {
    _resultRecorded = false;
    _game.reset();
    setState(() {});
  }

  String _statusMessage() {
    if (_game.winner == 'draw') {
      return "It's a draw!";
    } else if (_game.winner != null) {
      final name = _game.winner == 'X' ? widget.playerXName : widget.playerOName;
      return "$name (${_game.winner}) wins!";
    } else {
      final name = _game.currentPlayer == 'X' ? widget.playerXName : widget.playerOName;
      return "$name (${_game.currentPlayer})'s turn";
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: theme.text),
          onPressed: () => Navigator.pop(context),
        ),
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
