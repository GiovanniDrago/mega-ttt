import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'tic_tac_toe_game.dart';

class BoardComponent extends PositionComponent with TapCallbacks {
  final TicTacToeGame gameRef;
  Color gridColor;
  Color xColor;
  Color oColor;
  Color winLineColor;

  BoardComponent({
    required this.gameRef,
    required super.position,
    required super.size,
    required this.gridColor,
    required this.xColor,
    required this.oColor,
    required this.winLineColor,
  });

  void updateColors({
    required Color gridColor,
    required Color xColor,
    required Color oColor,
    required Color winLineColor,
  }) {
    this.gridColor = gridColor;
    this.xColor = xColor;
    this.oColor = oColor;
    this.winLineColor = winLineColor;
  }

  void refresh() {
    // Trigger redraw
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final cellW = size.x / 3;
    final cellH = size.y / 3;

    // Draw grid lines
    for (int i = 1; i < 3; i++) {
      // Vertical
      canvas.drawLine(
        Offset(i * cellW, 0),
        Offset(i * cellW, size.y),
        paint,
      );
      // Horizontal
      canvas.drawLine(
        Offset(0, i * cellH),
        Offset(size.x, i * cellH),
        paint,
      );
    }

    // Draw X and O
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        final value = gameRef.grid[row][col];
        if (value != null) {
          final center = Offset(
            col * cellW + cellW / 2,
            row * cellH + cellH / 2,
          );
          final radius = (cellW < cellH ? cellW : cellH) * 0.35;

          if (value == 'X') {
            _drawX(canvas, center, radius, xColor);
          } else {
            _drawO(canvas, center, radius, oColor);
          }
        }
      }
    }

    // Draw win line
    if (gameRef.winner != null && gameRef.winner != 'draw') {
      _drawWinLine(canvas, cellW, cellH);
    }
  }

  void _drawX(Canvas canvas, Offset center, double radius, Color color) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(center.dx - radius, center.dy - radius),
      Offset(center.dx + radius, center.dy + radius),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx + radius, center.dy - radius),
      Offset(center.dx - radius, center.dy + radius),
      paint,
    );
  }

  void _drawO(Canvas canvas, Offset center, double radius, Color color) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, paint);
  }

  void _drawWinLine(Canvas canvas, double cellW, double cellH) {
    final paint = Paint()
      ..color = winLineColor
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final winner = gameRef.winner!;

    // Check rows
    for (int i = 0; i < 3; i++) {
      if (gameRef.grid[i][0] == winner &&
          gameRef.grid[i][1] == winner &&
          gameRef.grid[i][2] == winner) {
        final start = Offset(0, i * cellH + cellH / 2);
        final end = Offset(size.x, i * cellH + cellH / 2);
        canvas.drawLine(start, end, paint);
        return;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (gameRef.grid[0][i] == winner &&
          gameRef.grid[1][i] == winner &&
          gameRef.grid[2][i] == winner) {
        final start = Offset(i * cellW + cellW / 2, 0);
        final end = Offset(i * cellW + cellW / 2, size.y);
        canvas.drawLine(start, end, paint);
        return;
      }
    }

    // Check diagonals
    if (gameRef.grid[0][0] == winner &&
        gameRef.grid[1][1] == winner &&
        gameRef.grid[2][2] == winner) {
      canvas.drawLine(Offset(0, 0), Offset(size.x, size.y), paint);
      return;
    }

    if (gameRef.grid[0][2] == winner &&
        gameRef.grid[1][1] == winner &&
        gameRef.grid[2][0] == winner) {
      canvas.drawLine(Offset(size.x, 0), Offset(0, size.y), paint);
      return;
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (gameRef.gameOver) return;

    final localPosition = event.localPosition;
    final cellW = size.x / 3;
    final cellH = size.y / 3;

    final col = (localPosition.x / cellW).floor();
    final row = (localPosition.y / cellH).floor();

    if (row >= 0 && row < 3 && col >= 0 && col < 3) {
      gameRef.makeMove(row, col);
    }
  }
}
