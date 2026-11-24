import 'package:flutter/material.dart';

import 'game.dart';
import 'widgets/game_board.dart';
import 'widgets/guess_input.dart';

void main() {
  runApp(const BirdleApp());
}

class BirdleApp extends StatelessWidget {
  const BirdleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Birdle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Game _game = Game();

  void _onGuess(String word) {
    if (word.length != _game.wordLength) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Use exatamente ${_game.wordLength} letras.')),
      );
      return;
    }
    setState(() => _game.guess(word));
  }

  void _restart() => setState(() => _game = Game());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Birdle'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GameBoard(_game),
                const SizedBox(height: 24),
                if (_game.isOver) ...[
                  Text(
                    _game.won
                        ? 'Você acertou!'
                        : 'Fim de jogo! A palavra era ${_game.secret}.',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: _restart,
                    child: const Text('Novo jogo'),
                  ),
                ] else
                  GuessInput(length: _game.wordLength, onSubmit: _onGuess),
              ],
            ),
          ),
        ),
      ),
    );
  }
}