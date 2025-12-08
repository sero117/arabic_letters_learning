import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'letter_screen.dart';

class ArabicKeyboardDialog extends StatefulWidget {
  const ArabicKeyboardDialog({Key? key}) : super(key: key);

  @override
  State<ArabicKeyboardDialog> createState() => _ArabicKeyboardDialogState();
}

class _ArabicKeyboardDialogState extends State<ArabicKeyboardDialog> {
  final FlutterTts _tts = FlutterTts();

  // القائمة الكاملة للحروف مع الحيوانات
  final List<Map<String, String>> lettersData = [
    {"letter": "أ", "animal": "أسد 🦁"},
    {"letter": "ب", "animal": "بطة 🦆"},
    {"letter": "ت", "animal": "تمساح 🐊"},
    {"letter": "ث", "animal": "ثعلب 🦊"},
    {"letter": "ج", "animal": "جمل 🐪"},
    {"letter": "ح", "animal": "حصان 🐎"},
    {"letter": "خ", "animal": "خروف 🐑"},
    {"letter": "د", "animal": "ديك 🐓"},
    {"letter": "ذ", "animal": "ذئب 🐺"},
    {"letter": "ر", "animal": "راكون 🦝"},
    {"letter": "ز", "animal": "زرافة 🦒"},
    {"letter": "س", "animal": "سمكة 🐟"},
    {"letter": "ش", "animal": "شبل 🦁"},
    {"letter": "ص", "animal": "صقر 🦅"},
    {"letter": "ض", "animal": "ضفدع 🐸"},
    {"letter": "ط", "animal": "طاووس 🦚"},
    {"letter": "ظ", "animal": "ظبي 🦌"},
    {"letter": "ع", "animal": "عصفور 🐦"},
    {"letter": "غ", "animal": "غزال 🦌"},
    {"letter": "ف", "animal": "فيل 🐘"},
    {"letter": "ق", "animal": "قرد 🐒"},
    {"letter": "ك", "animal": "كلب 🐕"},
    {"letter": "ل", "animal": "لبوة 🦁"},
    {"letter": "م", "animal": "ماعز 🐐"},
    {"letter": "ن", "animal": "نمر 🐅"},
    {"letter": "هـ", "animal": "هدهد 🐦"},
    {"letter": "و", "animal": "وزة 🦢"},
    {"letter": "ي", "animal": "يمامة 🕊️"},
  ];

  @override
  void initState() {
    super.initState();
    _tts.setLanguage("ar");
    _tts.setSpeechRate(0.5);
  }

  Future<void> _speakLetter(String letter) async {
    await _tts.stop();
    await _tts.speak(letter);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("اختر الحرف"),
      content: SizedBox(
        width: double.maxFinite,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: lettersData.length,
          itemBuilder: (context, index) {
            final letter = lettersData[index]["letter"]!;
            final animal = lettersData[index]["animal"]!;
            return InkWell(
              onTap: () async {
                await _speakLetter(letter);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        LetterScreen(letter: letter, animal: animal),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.purple[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  letter,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("إغلاق"),
        ),
      ],
    );
  }
}
