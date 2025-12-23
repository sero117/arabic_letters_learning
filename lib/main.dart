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
                  // زر الأحرف من جديد
                  ElevatedButton(
                    onPressed: () {
                      LetterScreen.completedLetters
                          .clear(); // إعادة تعيين الإنجاز
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
                        horizontal: 6,
                        vertical: 15,
                      ),
                      elevation: 8,
                    ),
                    child: Text(
                      "تعلم الأحرف من جديد",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 20),

                  // زر الأرقام من جديد
                  ElevatedButton(
                    onPressed: () {
                      FirstNumberScreen.completedNumbers
                          .clear(); // إعادة تعيين الإنجاز
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => FirstNumberScreen(
                            number: FirstNumberScreen.numbersData[0]["number"]!,
                            animal: FirstNumberScreen.numbersData[0]["animal"]!,
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
                        horizontal: 6,
                        vertical: 15,
                      ),
                      elevation: 8,
                    ),
                    child: Text(
                      "تعلم الأرقام من جديد",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),

              // زر متابعة من حيث توقفت
              ElevatedButton(
                onPressed: () {
                  // إذا كان هناك حروف مكتملة، نفتح أول حرف غير مكتمل
                  if (LetterScreen.completedLetters.length <
                      LetterScreen.lettersData.length) {
                    final nextIndex = LetterScreen.completedLetters.length;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LetterScreen(
                          letter:
                              LetterScreen.lettersData[nextIndex]["letter"]!,
                          animal:
                              LetterScreen.lettersData[nextIndex]["animal"]!,
                        ),
                      ),
                    );
                  }
                  // إذا كان هناك أرقام مكتملة، نفتح أول رقم غير مكتمل
                  else if (FirstNumberScreen.completedNumbers.length <
                      FirstNumberScreen.numbersData.length) {
                    final nextIndex = FirstNumberScreen.completedNumbers.length;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FirstNumberScreen(
                          number: FirstNumberScreen
                              .numbersData[nextIndex]["number"]!,
                          animal: FirstNumberScreen
                              .numbersData[nextIndex]["animal"]!,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  elevation: 8,
                ),
                child: Text(
                  "متابعة من حيث توقفت",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
