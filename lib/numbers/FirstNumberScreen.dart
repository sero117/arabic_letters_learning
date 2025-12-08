import 'package:arabic_letters_game/numbers/Final_celebrations_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Firstnumberscreen extends StatefulWidget {
  final String number;
  final String animal;

  const Firstnumberscreen({
    Key? key,
    required this.number,
    required this.animal,
  }) : super(key: key);

  // القائمة الكاملة للحروف مع الحيوانات
  static final List<Map<String, String>> lettersData = [
    {"number": "٠", "animal": ""},
    {"number": "١", "animal": " 🍎"},
    {"number": "٢", "animal": "🍎🍎"},
    {"number": "٣", "animal": "🍎🍎🍎"},
    {"number": "٤", "animal": "🍎🍎🍎🍎"},
    {"number": "٥", "animal": "🍎🍎🍎 🍎🍎"},
    {"number": "٦", "animal": "🍎🍎🍎 🍎🍎🍎"},
    {"number": "٧", "animal": "🍎🍎🍎 🍎🍎🍎 🍎"},
    {"number": "٨", "animal": "🍎🍎🍎 🍎🍎🍎 🍎🍎"},
    {"number": "٩", "animal": "🍎🍎🍎 🍎🍎🍎 🍎🍎🍎"},
    {"number": "١٠", "animal": "🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎"},
  ];

  @override
  State<Firstnumberscreen> createState() => _FirstnumberscreenState();
}

class _FirstnumberscreenState extends State<Firstnumberscreen> {
  Color selectedColor = Colors.red;
  List<ColoredPoint> brushStrokes = [];
  int strokesSinceLastDialog = 0;

  static Set<String> completedLetters = {}; // الحروف المكتملة

  @override
  Widget build(BuildContext context) {
    final double letterSize = MediaQuery.of(context).size.width * 3.8;
    int currentIndex = Firstnumberscreen.lettersData.indexWhere(
      (l) => l["number"] == widget.number,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("الرقم ${widget.number}"),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.keyboard),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const ArabicKeyboardDialog(),
              );
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // القائمة الجانبية للألوان والفرشاة
          Container(
            width: 80,
            color: Colors.grey.shade200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                const SizedBox(height: 20),
                Icon(Icons.brush, size: 40, color: selectedColor),
              ],
            ),
          ),

          // منطقة التلوين
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: SvgPicture.string(
                    '''
<svg xmlns="http://www.w3.org/5000/svg" width="200%" height="200%" viewBox="0 0 1000 1000">
  <text x="50%" y="70%" text-anchor="middle" dominant-baseline="middle"
        font-family="Amiri" font-size="800"
        fill="none" stroke="black" stroke-width="10">
    ${widget.number}
  </text>
</svg>
''',
                    width: letterSize,
                    height: letterSize,
                  ),
                ),
                GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      brushStrokes.add(
                        ColoredPoint(details.localPosition, selectedColor),
                      );
                      strokesSinceLastDialog++;
                      if (strokesSinceLastDialog > 150) {
                        strokesSinceLastDialog = 0;
                        completedLetters.add(widget.number); // طمس الحرف
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
        ],
      ),
    );
  }

  void _showSuccessDialog(int currentIndex) {
    if (completedLetters.length == Firstnumberscreen.lettersData.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => FinalCelebrationsNumbers()),
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
              widget.number.split(" ").last,
              style: const TextStyle(fontSize: 40),
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
              if (currentIndex + 1 < Firstnumberscreen.lettersData.length) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Firstnumberscreen(
                      number: Firstnumberscreen
                          .lettersData[currentIndex + 1]["number"]!,
                      animal: Firstnumberscreen
                          .lettersData[currentIndex + 1]["animal"]!,
                    ),
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
            child: const Text("➡️ إلى الرقم التالي"),
          ),
        ],
      ),
    );
  }

  Widget _colorButton(Color color) {
    return GestureDetector(
      onTap: () => setState(() => selectedColor = color),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selectedColor == color ? Colors.black : Colors.transparent,
            width: 3,
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
    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      if (p1.offset != Offset.zero && p2.offset != Offset.zero) {
        final paint = Paint()
          ..color = p1.color.withOpacity(0.6)
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 25;
        canvas.drawLine(p1.offset, p2.offset, paint);
      }
    }
  }

  @override
  bool shouldRepaint(BrushPainter oldDelegate) => true;
}

// الكيبورد المنزلق
class ArabicKeyboardDialog extends StatefulWidget {
  const ArabicKeyboardDialog({Key? key}) : super(key: key);

  @override
  State<ArabicKeyboardDialog> createState() => _ArabicKeyboardDialogState();
}

class _ArabicKeyboardDialogState extends State<ArabicKeyboardDialog> {
  final FlutterTts _tts = FlutterTts();

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
      title: const Text("اختر الرقم"),
      content: SizedBox(
        width: double.maxFinite,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: Firstnumberscreen.lettersData.length,
          itemBuilder: (context, index) {
            final letter = Firstnumberscreen.lettersData[index]["number"]!;
            final animal = Firstnumberscreen.lettersData[index]["animal"]!;
            final isCompleted = _FirstnumberscreenState.completedLetters
                .contains(letter);

            return InkWell(
              onTap: isCompleted
                  ? null
                  : () async {
                      await _speakLetter(letter);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              Firstnumberscreen(number: letter, animal: animal),
                        ),
                      );
                    },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? Colors.grey.shade400
                      : Colors.purple[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  letter,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isCompleted ? Colors.white : Colors.black,
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
