import 'package:arabic_letters_game/Keyboard/letter_screen.dart';
import 'package:flutter/material.dart';

class ArabicKeyboardWidget extends StatelessWidget {
  final Function(String letter, String animal) onSelect;

  const ArabicKeyboardWidget({Key? key, required this.onSelect})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.grey.shade300,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: LetterScreen.lettersData.map((data) {
            final letter = data["letter"]!;
            final animal = data["animal"]!;
            final isCompleted = LetterScreen.completedLetters.contains(letter);

            return GestureDetector(
              onTap: isCompleted ? null : () => onSelect(letter, animal),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                width: 60,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isCompleted ? Colors.grey.shade400 : Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  letter,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: isCompleted ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
