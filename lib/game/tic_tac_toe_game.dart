import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'board_component.dart';
import '../models/game_theme.dart';

class TicTacToeGame extends FlameGame with TapCallbacks {
  final VoidCallback onStateChanged;
  GameTheme theme;

  TicTacToeGame({required this.onStateChanged, required this.theme});

  late BoardComponent board;

  List<List<String?>> grid = List.generate(3, (_) => List.generate(3, (_) => null));
  String currentPlayer = 'X';
  String? winner;
  bool gameOver = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    board = BoardComponent(
      gameRef: this,
      position: Vector2.zero(),
      size: size,
      gridColor: theme.gridColor,
      xColor: theme.xColor,
      oColor: theme.oColor,
      winLineColor: theme.winLineColor,
    );
    add(board);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    if (isLoaded) {
      board.size = size;
      board.position = Vector2.zero();
      board.refresh();
    }
  }

  bool makeMove(int row, int col) {
    if (gameOver || grid[row][col] != null) {
      return false;
    }

    grid[row][col] = currentPlayer;
    board.refresh();
    onStateChanged();

    if (_checkWinner(currentPlayer)) {
      winner = currentPlayer;
      gameOver = true;
      onStateChanged();
      return true;
    }

    if (_checkDraw()) {
      winner = 'draw';
      gameOver = true;
      onStateChanged();
      return true;
    }

    currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    onStateChanged();
    return true;
  }

  bool _checkWinner(String player) {
    // Rows
    for (int i = 0; i < 3; i++) {
      if (grid[i][0] == player && grid[i][1] == player && grid[i][2] == player) {
        return true;
      }
    }
    // Columns
    for (int i = 0; i < 3; i++) {
      if (grid[0][i] == player && grid[1][i] == player && grid[2][i] == player) {
        return true;
      }
    }
    // Diagonals
    if (grid[0][0] == player && grid[1][1] == player && grid[2][2] == player) {
      return true;
    }
    if (grid[0][2] == player && grid[1][1] == player && grid[2][0] == player) {
      return true;
    }
    return false;
  }

  bool _checkDraw() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (grid[i][j] == null) {
          return false;
        }
      }
    }
    return true;
  }

  void reset() {
    grid = List.generate(3, (_) => List.generate(3, (_) => null));
    currentPlayer = 'X';
    winner = null;
    gameOver = false;
    board.refresh();
    onStateChanged();
  }
}
