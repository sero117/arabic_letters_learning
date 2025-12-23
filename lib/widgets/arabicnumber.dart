import 'package:arabic_letters_game/numbers/FirstNumberScreen.dart';
import 'package:flutter/material.dart';

class ArabicNumbersKeyboardWidget extends StatelessWidget {
  final Function(String number, String animal) onSelect;

  const ArabicNumbersKeyboardWidget({Key? key, required this.onSelect})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.grey.shade300,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: FirstNumberScreen.numbersData.map((data) {
            final number = data["number"]!;
            final animal = data["animal"]!;
            final isCompleted = FirstNumberScreen.completedNumbers.contains(
              number,
            );

            return GestureDetector(
              onTap: isCompleted ? null : () => onSelect(number, animal),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                width: 60,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isCompleted ? Colors.grey.shade400 : Colors.green[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  number,
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
