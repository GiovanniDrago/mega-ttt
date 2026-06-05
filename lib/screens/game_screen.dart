import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../game/tic_tac_toe_game.dart';
import '../game/mini_board_game.dart';
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
    } else if (_game.activeSector != null) {
      final name = _game.currentPlayer == 'X' ? widget.playerXName : widget.playerOName;
      return "$name (${_game.currentPlayer}) \u2014 place your mark";
    } else {
      final name = _game.currentPlayer == 'X' ? widget.playerXName : widget.playerOName;
      return "$name (${_game.currentPlayer}) \u2014 choose a sector";
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final activeSector = _game.activeSector;

    if (activeSector != null) {
      return _buildZoomedView(theme, activeSector);
    }
    return _buildOverview(theme);
  }

  Widget _buildOverview(GameTheme theme) {
    final screenSize = MediaQuery.of(context).size;
    final boardSize = screenSize.width < screenSize.height
        ? screenSize.width * 0.9
        : screenSize.height * 0.65;

    final bool gameEnded = _game.gameOver;

    final hasWinner = _game.winner != null && _game.winner != 'draw';
    final isDraw = _game.winner == 'draw';
    final isX = _game.winner == 'X';

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
              const SizedBox(height: 8),
              Text(
                'Ultimate Tic Tac Toe',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: theme.title,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: statusBorder, width: 2),
                ),
                child: Text(
                  _statusMessage(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: statusTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: boardSize,
                height: boardSize,
                child: GridView.count(
                  crossAxisCount: 3,
                  padding: EdgeInsets.zero,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(9, (i) => _buildSectorCell(i, theme, gameEnded)),
                ),
              ),
              const SizedBox(height: 16),
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

  Widget _buildSectorCell(int index, GameTheme theme, bool gameEnded) {
    final result = _game.sectorResults[index];
    final isPlayable = result == null && !gameEnded;

    return GestureDetector(
      onTap: isPlayable ? () => _game.selectSector(index) : null,
      child: Container(
        decoration: BoxDecoration(
          color: theme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: result != null
                ? theme.gridColor.withOpacity(0.15)
                : theme.gridColor.withOpacity(0.4),
            width: result != null ? 1 : 1.5,
          ),
        ),
        child: result != null
            ? _buildResultOverlay(result, theme)
            : _buildMiniGrid(_game.grids[index], theme),
      ),
    );
  }

  Widget _buildResultOverlay(String result, GameTheme theme) {
    if (result == 'draw') {
      return Center(
        child: Text(
          '\u2014',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w200,
            color: theme.text.withOpacity(0.3),
          ),
        ),
      );
    }
    final color = result == 'X' ? theme.xColor : theme.oColor;
    return Center(
      child: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: CustomPaint(
            painter: result == 'X' ? _BigXPainter(color) : _BigOPainter(color),
          ),
        ),
      ),
    );
  }

  Widget _buildMiniGrid(List<List<String?>> grid, GameTheme theme) {
    final borderSide = BorderSide(color: theme.gridColor.withOpacity(0.35), width: 0.5);
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        children: List.generate(3, (row) => Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: row < 2 ? borderSide : BorderSide.none,
              ),
            ),
            child: Row(
              children: List.generate(3, (col) => Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: col < 2 ? borderSide : BorderSide.none,
                    ),
                  ),
                  child: Center(
                    child: _miniCellWidget(grid[row][col], theme),
                  ),
                ),
              )),
            ),
          ),
        )),
      ),
    );
  }

  Widget _miniCellWidget(String? value, GameTheme theme) {
    if (value == null) return const SizedBox.shrink();

    final color = value == 'X' ? theme.xColor : theme.oColor;
    return Padding(
      padding: const EdgeInsets.all(2),
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _MiniCellPainter(value, color),
        ),
      ),
    );
  }

  Widget _buildZoomedView(GameTheme theme, int sector) {
    final screenSize = MediaQuery.of(context).size;
    final boardSize = screenSize.width < screenSize.height
        ? screenSize.width * 0.9
        : screenSize.height * 0.7;

    final sectorResult = _game.sectorResults[sector];

    final hasWinner = _game.winner != null && _game.winner != 'draw';
    final isDraw = _game.winner == 'draw';
    final isX = _game.winner == 'X';

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

    final miniGame = MiniBoardGame(game: _game, sector: sector);

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: theme.text),
          onPressed: () => _game.backToOverview(),
        ),
        title: Text(
          'Sector ${sector + 1}',
          style: TextStyle(color: theme.text, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: statusBorder, width: 2),
                ),
                child: Text(
                  _statusMessage(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: statusTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: boardSize,
                height: boardSize,
                child: sectorResult != null
                    ? _buildResultOverlay(sectorResult, theme)
                    : GameWidget(
                        key: ValueKey(sector),
                        game: miniGame,
                      ),
              ),
              const SizedBox(height: 16),
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

class _BigXPainter extends CustomPainter {
  final Color color;

  _BigXPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final margin = size.width * 0.15;
    canvas.drawLine(
      Offset(margin, margin),
      Offset(size.width - margin, size.height - margin),
      paint,
    );
    canvas.drawLine(
      Offset(size.width - margin, margin),
      Offset(margin, size.height - margin),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _BigXPainter old) => old.color != color;
}

class _BigOPainter extends CustomPainter {
  final Color color;

  _BigOPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.38;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _BigOPainter old) => old.color != color;
}

class _MiniCellPainter extends CustomPainter {
  final String symbol;
  final Color color;

  _MiniCellPainter(this.symbol, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    if (symbol == 'X') {
      final margin = size.width * 0.22;
      canvas.drawLine(
        Offset(margin, margin),
        Offset(size.width - margin, size.height - margin),
        paint,
      );
      canvas.drawLine(
        Offset(size.width - margin, margin),
        Offset(margin, size.height - margin),
        paint,
      );
    } else {
      final center = Offset(size.width / 2, size.height / 2);
      final radius = size.width * 0.35;
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _MiniCellPainter old) =>
      old.symbol != symbol || old.color != color;
}
