import 'dart:math';

import 'words.dart';

enum HitType { none, hit, partial, miss }

class Letter {
  const Letter(this.char, this.type);

  final String char;
  final HitType type;
}

class Game {
  Game({this.maxGuesses = 6, this.wordLength = 5}) {
    secret = allWords[Random().nextInt(allWords.length)];
    guesses = List.generate(
      maxGuesses,
      (_) => List.generate(wordLength, (_) => const Letter('', HitType.none)),
    );
  }

  final int maxGuesses;
  final int wordLength;
  late final String secret;
  late final List<List<Letter>> guesses;

  int currentGuess = 0;
  bool won = false;

  bool get isOver => won || currentGuess >= maxGuesses;

  /// Avalia a tentativa. Retorna false se ela for inválida.
  bool guess(String input) {
    final word = input.toUpperCase();
    if (isOver || word.length != wordLength) return false;

    final result = List<HitType>.filled(wordLength, HitType.miss);
    final remaining = <String, int>{};

    // 1ª passada: acertos na posição correta
    for (var i = 0; i < wordLength; i++) {
      if (word[i] == secret[i]) {
        result[i] = HitType.hit;
      } else {
        remaining[secret[i]] = (remaining[secret[i]] ?? 0) + 1;
      }
    }

    // 2ª passada: letra certa na posição errada
    for (var i = 0; i < wordLength; i++) {
      if (result[i] == HitType.hit) continue;
      final c = word[i];
      if ((remaining[c] ?? 0) > 0) {
        result[i] = HitType.partial;
        remaining[c] = remaining[c]! - 1;
      }
    }

    guesses[currentGuess] = [
      for (var i = 0; i < wordLength; i++) Letter(word[i], result[i]),
    ];
    won = word == secret;
    currentGuess++;
    return true;
  }
}