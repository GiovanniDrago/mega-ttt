import 'package:flutter/foundation.dart';
import '../models/game_theme.dart';

class TicTacToeGame {
  final VoidCallback onStateChanged;
  GameTheme theme;

  TicTacToeGame({required this.onStateChanged, required this.theme});

  List<List<List<String?>>> grids = List.generate(
    9,
    (_) => List.generate(3, (_) => List.generate(3, (_) => null)),
  );

  List<String?> sectorResults = List.filled(9, null);

  String currentPlayer = 'X';
  String? winner;
  bool gameOver = false;
  int? activeSector;
  int? targetSector;
  int? focusedRow;
  int? focusedCol;

  bool selectSector(int index) {
    if (gameOver) return false;
    if (index < 0 || index > 8) return false;
    activeSector = index;
    onStateChanged();
    return true;
  }

  void backToOverview() {
    activeSector = null;
    focusedRow = null;
    focusedCol = null;
    onStateChanged();
  }

  bool makeMove(int row, int col) {
    if (gameOver) return false;
    if (activeSector == null) return false;
    final s = activeSector!;
    if (sectorResults[s] != null) return false;
    if (grids[s][row][col] != null) return false;
    if (targetSector != null && activeSector != targetSector) return false;

    grids[s][row][col] = currentPlayer;
    onStateChanged();

    _checkSectorResult(s);
    if (gameOver) return true;

    currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    targetSector = row * 3 + col;
    if (sectorResults[targetSector!] != null) {
      targetSector = null;
    }
    activeSector = null;
    onStateChanged();
    return true;
  }

  void _checkSectorResult(int s) {
    final grid = grids[s];
    if (_checkGridWinner(grid, 'X')) {
      sectorResults[s] = 'X';
      _checkOverallWin();
      return;
    }
    if (_checkGridWinner(grid, 'O')) {
      sectorResults[s] = 'O';
      _checkOverallWin();
      return;
    }
    if (_checkGridDraw(grid)) {
      int xCount = 0, oCount = 0;
      for (int r = 0; r < 3; r++) {
        for (int c = 0; c < 3; c++) {
          if (grid[r][c] == 'X') xCount++;
          if (grid[r][c] == 'O') oCount++;
        }
      }
      if (xCount > oCount) {
        sectorResults[s] = 'X';
      } else if (oCount > xCount) {
        sectorResults[s] = 'O';
      } else {
        sectorResults[s] = 'draw';
      }
      _checkOverallWin();
    }
  }

  void _checkOverallWin() {
    final results = sectorResults
        .map((r) => r == 'X' || r == 'O' ? r : null)
        .toList();

    if (_checkLineWinner(results, 'X')) {
      winner = 'X';
      gameOver = true;
      return;
    }
    if (_checkLineWinner(results, 'O')) {
      winner = 'O';
      gameOver = true;
      return;
    }

    final allDecided = sectorResults.every((r) => r != null);
    if (allDecided) {
      winner = 'draw';
      gameOver = true;
    }
  }

  void reset() {
    grids = List.generate(
      9,
      (_) => List.generate(3, (_) => List.generate(3, (_) => null)),
    );
    sectorResults = List.filled(9, null);
    currentPlayer = 'X';
    winner = null;
    gameOver = false;
    activeSector = null;
    targetSector = null;
    focusedRow = null;
    focusedCol = null;
    onStateChanged();
  }

  void updateTheme(GameTheme newTheme) {
    theme = newTheme;
    onStateChanged();
  }

  static bool _checkGridWinner(List<List<String?>> grid, String player) {
    final lines = _gridLines(grid);
    for (final line in lines) {
      if (line[0] == player && line[1] == player && line[2] == player) {
        return true;
      }
    }
    return false;
  }

  static bool _checkGridDraw(List<List<String?>> grid) {
    for (int r = 0; r < 3; r++) {
      for (int c = 0; c < 3; c++) {
        if (grid[r][c] == null) return false;
      }
    }
    return true;
  }

  static bool _checkLineWinner(List<String?> cells, String player) {
    final lines = _gridLines3(cells);
    for (final line in lines) {
      if (line[0] == player && line[1] == player && line[2] == player) {
        return true;
      }
    }
    return false;
  }

  static List<List<String?>> _gridLines(List<List<String?>> grid) {
    return [
      [grid[0][0], grid[0][1], grid[0][2]],
      [grid[1][0], grid[1][1], grid[1][2]],
      [grid[2][0], grid[2][1], grid[2][2]],
      [grid[0][0], grid[1][0], grid[2][0]],
      [grid[0][1], grid[1][1], grid[2][1]],
      [grid[0][2], grid[1][2], grid[2][2]],
      [grid[0][0], grid[1][1], grid[2][2]],
      [grid[0][2], grid[1][1], grid[2][0]],
    ];
  }

  static List<List<String?>> _gridLines3(List<String?> cells) {
    return [
      [cells[0], cells[1], cells[2]],
      [cells[3], cells[4], cells[5]],
      [cells[6], cells[7], cells[8]],
      [cells[0], cells[3], cells[6]],
      [cells[1], cells[4], cells[7]],
      [cells[2], cells[5], cells[8]],
      [cells[0], cells[4], cells[8]],
      [cells[2], cells[4], cells[6]],
    ];
  }
}
