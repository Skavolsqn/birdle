import 'package:flutter/material.dart';

import '../game.dart';

class Tile extends StatelessWidget {
  const Tile(this.letter, {super.key});

  final Letter letter;

  static const double size = 52;

  Color get _background => switch (letter.type) {
        HitType.hit => Colors.green,
        HitType.partial => Colors.amber.shade700,
        HitType.miss => Colors.grey.shade700,
        HitType.none => Colors.transparent,
      };

  @override
  Widget build(BuildContext context) {
    final empty = letter.type == HitType.none;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: size,
      height: size,
      margin: const EdgeInsets.all(3),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _background,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: empty ? Colors.grey.shade400 : Colors.transparent,
          width: 2,
        ),
      ),
      child: Text(
        letter.char,
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: empty ? null : Colors.white,
        ),
      ),
    );
  }
}