import 'package:flutter/material.dart';

import '../game.dart';
import 'tile.dart';

class GameBoard extends StatelessWidget {
  const GameBoard(this.game, {super.key});

  final Game game;

  @override
  Widget build(BuildContext context) {
    // FittedBox reduz a grade em telas muito estreitas (evita overflow).
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final guess in game.guesses)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final letter in guess) Tile(letter),
              ],
            ),
        ],
      ),
    );
  }
}