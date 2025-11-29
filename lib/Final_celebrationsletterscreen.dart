import 'dart:io';

import 'package:arabic_letters_game/first_letter_screen.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class FinalCelebrationScreen extends StatefulWidget {
  @override
  _FinalCelebrationScreenState createState() => _FinalCelebrationScreenState();
}

class _FinalCelebrationScreenState extends State<FinalCelebrationScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 5),
    );
    _confettiController.play(); // تشغيل المفرقعات عند الدخول
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade100,
      body: Stack(
        children: [
          // مؤثرات المفرقعات
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              maxBlastForce: 30,
              minBlastForce: 10,
              gravity: 0.3,
              colors: const [
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.orange,
                Colors.purple,
                Colors.yellow,
              ],
            ),
          ),

          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "🎉 تهانينا 🎉",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "لقد أنهيت جميع الحروف العربية!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // جميع الحروف العربية
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (var letter in [
                        "أ",
                        "ب",
                        "ت",
                        "ث",
                        "ج",
                        "ح",
                        "خ",
                        "د",
                        "ذ",
                        "ر",
                        "ز",
                        "س",
                        "ش",
                        "ص",
                        "ض",
                        "ط",
                        "ظ",
                        "ع",
                        "غ",
                        "ف",
                        "ق",
                        "ك",
                        "ل",
                        "م",
                        "ن",
                        "هـ",
                        "و",
                        "ي",
                      ])
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            letter,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 50),

                  // أزرار التحكم
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  FirstLetterScreen(), // صفحة الحرف الأول
                            ),
                          );
                        },
                        icon: const Icon(Icons.refresh, color: Colors.white),
                        label: const Text("ابدأ من جديد"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          exit(0);
                        },
                        icon: const Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                        ),
                        label: const Text("خروج"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
