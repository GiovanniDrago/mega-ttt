import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game/tic_tac_toe_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mega TTT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late TicTacToeGame _game;

  @override
  void initState() {
    super.initState();
    _game = TicTacToeGame(onStateChanged: () {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void _resetGame() {
    setState(() {
      _game = TicTacToeGame(onStateChanged: () {
        if (mounted) {
          setState(() {});
        }
      });
    });
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
    final screenSize = MediaQuery.of(context).size;
    final boardSize = screenSize.width < screenSize.height
        ? screenSize.width * 0.9
        : screenSize.height * 0.7;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
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
                  color: Colors.white.withOpacity(0.9),
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: _game.winner != null
                      ? (_game.winner == 'draw'
                          ? Colors.orange.withOpacity(0.2)
                          : (_game.winner == 'X'
                              ? Colors.blue.withOpacity(0.2)
                              : Colors.red.withOpacity(0.2)))
                      : Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _game.winner != null
                        ? (_game.winner == 'draw'
                            ? Colors.orange
                            : (_game.winner == 'X' ? Colors.blue : Colors.red))
                        : Colors.white.withOpacity(0.1),
                    width: 2,
                  ),
                ),
                child: Text(
                  _statusMessage(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: _game.winner != null
                        ? (_game.winner == 'draw'
                            ? Colors.orange
                            : (_game.winner == 'X' ? Colors.blue : Colors.red))
                        : Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: boardSize,
                height: boardSize,
                child: GameWidget(
                  game: _game,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _resetGame,
                icon: const Icon(Icons.refresh, size: 24),
                label: const Text(
                  'Reset Game',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  backgroundColor: Colors.deepPurple,
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
