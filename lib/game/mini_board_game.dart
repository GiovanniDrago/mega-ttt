import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'board_component.dart';
import 'tic_tac_toe_game.dart';

class MiniBoardGame extends FlameGame with TapCallbacks {
  final TicTacToeGame game;
  final int sector;
  final Color _backgroundColor;

  MiniBoardGame({
    required this.game,
    required this.sector,
    required Color backgroundColor,
  }) : _backgroundColor = backgroundColor;

  @override
  Color backgroundColor() => _backgroundColor;

  late BoardComponent board;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    board = BoardComponent(
      game: game,
      sector: sector,
      position: Vector2.zero(),
      size: size,
      gridColor: game.theme.gridColor,
      xColor: game.theme.xColor,
      oColor: game.theme.oColor,
      winLineColor: game.theme.winLineColor,
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

  void updateColors({
    required Color gridColor,
    required Color xColor,
    required Color oColor,
    required Color winLineColor,
  }) {
    board.updateColors(
      gridColor: gridColor,
      xColor: xColor,
      oColor: oColor,
      winLineColor: winLineColor,
    );
    board.refresh();
  }
}
