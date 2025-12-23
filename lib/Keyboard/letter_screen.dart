import 'package:arabic_letters_game/letters/Final_celebrationsletterscreen.dart';
import 'package:arabic_letters_game/main.dart';
import 'package:arabic_letters_game/widgets/arabicwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';

class LetterScreen extends StatefulWidget {
  final String letter;
  final String animal;

  const LetterScreen({Key? key, required this.letter, required this.animal})
    : super(key: key);

  static final List<Map<String, String>> lettersData = [
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

  static Set<String> completedLetters = {};

  @override
  State<LetterScreen> createState() => _LetterScreenState();
}

class _LetterScreenState extends State<LetterScreen> {
  Color selectedColor = Colors.red;
  List<ColoredPoint> brushStrokes = [];
  int strokesSinceLastDialog = 0;
  bool showColors = false;

  @override
  Widget build(BuildContext context) {
    int currentIndex = LetterScreen.lettersData.indexWhere(
      (l) => l["letter"] == widget.letter,
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("الحرف ${widget.letter}"),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: currentIndex > 0
              ? () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LetterScreen(
                        letter: LetterScreen
                            .lettersData[currentIndex - 1]["letter"]!,
                        animal: LetterScreen
                            .lettersData[currentIndex - 1]["animal"]!,
                      ),
                    ),
                  );
                }
              : null,
        ),
        actions: [
          // زر التالي
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: currentIndex + 1 < LetterScreen.lettersData.length
                ? () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LetterScreen(
                          letter: LetterScreen
                              .lettersData[currentIndex + 1]["letter"]!,
                          animal: LetterScreen
                              .lettersData[currentIndex + 1]["animal"]!,
                        ),
                      ),
                    );
                  }
                : null,
          ),
          IconButton(
            icon: const Icon(Icons.outbox_outlined),
            onPressed: currentIndex + 1 < LetterScreen.lettersData.length
                ? () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => SplashScreen()),
                    );
                  }
                : null,
          ),
        ],
      ),
      body: Column(
        children: [
          // منطقة التلوين
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: SvgPicture.string(
                    '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1500 1500" width="100%" height="100%">
  <text x="50%" y="60%"
        text-anchor="middle"
        dominant-baseline="middle"
        font-size="900"
        font-family="sans-serif"
        fill="none"
        stroke="black"
        stroke-width="4">
    ${widget.letter}
  </text>
</svg>
''',
                    width: MediaQuery.of(context).size.width * 2.0,
                    height: MediaQuery.of(context).size.width * 2.0,
                  ),
                ),
                GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      brushStrokes.add(
                        ColoredPoint(details.localPosition, selectedColor),
                      );
                      strokesSinceLastDialog++;
                      if (strokesSinceLastDialog > 200) {
                        strokesSinceLastDialog = 0;
                        LetterScreen.completedLetters.add(widget.letter);
                        _showSuccessDialog(currentIndex);
                      }
                    });
                  },
                  onPanEnd: (_) => brushStrokes.add(
                    ColoredPoint(Offset.zero, selectedColor),
                  ),
                  child: CustomPaint(
                    painter: BrushPainter(brushStrokes),
                    size: Size.infinite,
                  ),
                ),
              ],
            ),
          ),
          ArabicKeyboardWidget(
            onSelect: (letter, animal) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => LetterScreen(letter: letter, animal: animal),
                ),
              );
            },
          ),

          // شريط الألوان بالأسفل مع السحب
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.grey.shade200,
            child: Row(
              children: [
                // اللون الحالي
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: selectedColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                ),
                const SizedBox(width: 20),

                // أيقونة الفرشاة
                IconButton(
                  icon: Icon(Icons.brush, size: 40, color: selectedColor),
                  onPressed: () {
                    setState(() {
                      showColors = !showColors;
                    });
                  },
                ),

                // باقي الألوان داخل Scroll أفقي
                if (showColors)
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _colorButton(Colors.red),
                          _colorButton(Colors.blue),
                          _colorButton(Colors.green),
                          _colorButton(Colors.orange),
                          _colorButton(Colors.purple),
                          _colorButton(Colors.yellow),
                          _colorButton(Colors.pink),
                          _colorButton(Colors.brown),
                          _colorButton(Colors.cyan),
                          _colorButton(Colors.teal),
                          _colorButton(Colors.black),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(int currentIndex) {
    if (LetterScreen.completedLetters.length ==
        LetterScreen.lettersData.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => FinalCelebrationScreen()),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("أحسنت 🎉"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.letter,
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              widget.animal,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (currentIndex + 1 < LetterScreen.lettersData.length) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LetterScreen(
                      letter:
                          LetterScreen.lettersData[currentIndex + 1]["letter"]!,
                      animal:
                          LetterScreen.lettersData[currentIndex + 1]["animal"]!,
                    ),
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
            child: const Text("➡️ إلى الحرف التالي"),
          ),
        ],
      ),
    );
  }

  Widget _colorButton(Color color) {
    return GestureDetector(
      onTap: () => setState(() {
        selectedColor = color;
        showColors = false;
      }),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selectedColor == color ? Colors.black : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }
}

class ColoredPoint {
  final Offset offset;
  final Color color;
  ColoredPoint(this.offset, this.color);
}

class BrushPainter extends CustomPainter {
  final List<ColoredPoint> points;
  BrushPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in points) {
      if (p.offset != Offset.zero) {
        final paint = Paint()
          ..color = p.color.withOpacity(0.6)
          ..style = PaintingStyle.fill;
        canvas.drawCircle(p.offset, 15, paint); // نقاط بدل خطوط
      }
    }
  }

  @override
  bool shouldRepaint(BrushPainter oldDelegate) => true;
}
