import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GuessInput extends StatefulWidget {
  const GuessInput({super.key, required this.length, required this.onSubmit});

  final int length;
  final ValueChanged<String> onSubmit;

  @override
  State<GuessInput> createState() => _GuessInputState();
}

class _GuessInputState extends State<GuessInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    widget.onSubmit(text);
    if (text.length == widget.length) _controller.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              maxLength: widget.length,
              textCapitalization: TextCapitalization.characters,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
              ],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite uma palavra de 5 letras',
              ),
              onSubmitted: (_) => _submit(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            onPressed: _submit,
            icon: const Icon(Icons.send),
            tooltip: 'Enviar',
          ),
        ],
      ),
    );
  }
}