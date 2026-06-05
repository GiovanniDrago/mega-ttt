import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'tic_tac_toe_game.dart';

class BoardComponent extends PositionComponent with TapCallbacks {
  final TicTacToeGame game;
  final int sector;
  Color gridColor;
  Color xColor;
  Color oColor;
  Color winLineColor;

  BoardComponent({
    required this.game,
    required this.sector,
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

  void refresh() {}

  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final grid = game.grids[sector];
    final result = game.sectorResults[sector];
    final cellW = size.x / 3;
    final cellH = size.y / 3;

    final linePaint = Paint()
      ..color = gridColor
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    for (int i = 1; i < 3; i++) {
      canvas.drawLine(
        Offset(i * cellW, 0),
        Offset(i * cellW, size.y),
        linePaint,
      );
      canvas.drawLine(
        Offset(0, i * cellH),
        Offset(size.x, i * cellH),
        linePaint,
      );
    }

    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        final value = grid[row][col];
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

    if (result != null && result != 'draw') {
      _drawWinLine(canvas, grid, result, cellW, cellH);
    }

    final fr = game.focusedRow;
    final fc = game.focusedCol;
    if (fr != null && fc != null && result == null && !game.gameOver) {
      final focusPaint = Paint()
        ..color = game.theme.accent.withOpacity(0.5)
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke;
      canvas.drawRect(
        Rect.fromLTWH(fc * cellW + 3, fr * cellH + 3, cellW - 6, cellH - 6),
        focusPaint,
      );
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

  void _drawWinLine(
    Canvas canvas,
    List<List<String?>> grid,
    String winner,
    double cellW,
    double cellH,
  ) {
    final paint = Paint()
      ..color = winLineColor
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 3; i++) {
      if (grid[i][0] == winner &&
          grid[i][1] == winner &&
          grid[i][2] == winner) {
        final start = Offset(0, i * cellH + cellH / 2);
        final end = Offset(size.x, i * cellH + cellH / 2);
        canvas.drawLine(start, end, paint);
        return;
      }
    }

    for (int i = 0; i < 3; i++) {
      if (grid[0][i] == winner &&
          grid[1][i] == winner &&
          grid[2][i] == winner) {
        final start = Offset(i * cellW + cellW / 2, 0);
        final end = Offset(i * cellW + cellW / 2, size.y);
        canvas.drawLine(start, end, paint);
        return;
      }
    }

    if (grid[0][0] == winner &&
        grid[1][1] == winner &&
        grid[2][2] == winner) {
      canvas.drawLine(Offset(0, 0), Offset(size.x, size.y), paint);
      return;
    }

    if (grid[0][2] == winner &&
        grid[1][1] == winner &&
        grid[2][0] == winner) {
      canvas.drawLine(Offset(size.x, 0), Offset(0, size.y), paint);
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (game.gameOver) return;
    if (game.sectorResults[sector] != null) return;

    final localPosition = event.localPosition;
    final cellW = size.x / 3;
    final cellH = size.y / 3;

    final col = (localPosition.x / cellW).floor();
    final row = (localPosition.y / cellH).floor();

    if (row >= 0 && row < 3 && col >= 0 && col < 3) {
      game.focusedRow = row;
      game.focusedCol = col;
      game.makeMove(row, col);
      refresh();
    }
  }
}
