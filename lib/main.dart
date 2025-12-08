import 'package:arabic_letters_game/Keyboard/letter_screen.dart';
import 'package:arabic_letters_game/numbers/FirstNumberScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'لعبة الأحرف والأرقام العربية',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.brush, size: 120, color: Colors.white),
              SizedBox(height: 30),

              Text(
                "مرحبًا بكم يا أبطال 🎉",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),

              Text(
                "اختر ما تريد تعلمه: الأحرف أو الأرقام 🎨",
                style: TextStyle(fontSize: 22, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),

              // صف فيه زرين
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // زر الأحرف
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LetterScreen(
                            letter: LetterScreen.lettersData[0]["letter"]!,
                            animal: LetterScreen.lettersData[0]["animal"]!,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      elevation: 8,
                    ),
                    child: Text(
                      "تعلم الأحرف",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 20),

                  // زر الأرقام
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => Firstnumberscreen(
                            number: Firstnumberscreen.lettersData[0]["number"]!,
                            animal: Firstnumberscreen.lettersData[0]["number"]!,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      elevation: 8,
                    ),
                    child: Text(
                      "تعلم الأرقام",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
