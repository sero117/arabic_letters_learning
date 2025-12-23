import 'package:arabic_letters_game/main.dart';
import 'package:arabic_letters_game/numbers/Final_celebrations_numbers.dart';
import 'package:arabic_letters_game/widgets/arabicnumber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FirstNumberScreen extends StatefulWidget {
  final String number;
  final String animal;

  const FirstNumberScreen({
    Key? key,
    required this.number,
    required this.animal,
  }) : super(key: key);

  // قائمة الأرقام مع الحيوانات/الرموز
  static final List<Map<String, String>> numbersData = [
    {"number": "٠", "animal": ""},
    {"number": "١", "animal": "🍎"},
    {"number": "٢", "animal": "🍎🍎"},
    {"number": "٣", "animal": "🍎🍎🍎"},
    {"number": "٤", "animal": "🍎🍎🍎🍎"},
    {"number": "٥", "animal": "🍎🍎🍎🍎🍎"},
    {"number": "٦", "animal": "🍎🍎🍎🍎🍎🍎"},
    {"number": "٧", "animal": "🍎🍎🍎🍎🍎🍎🍎"},
    {"number": "٨", "animal": "🍎🍎🍎🍎🍎🍎🍎🍎"},
    {"number": "٩", "animal": "🍎🍎🍎🍎🍎🍎🍎🍎🍎"},
    {"number": "١٠", "animal": "🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎"},
  ];

  static Set<String> completedNumbers = {};

  @override
  State<FirstNumberScreen> createState() => _FirstNumberScreenState();
}

class _FirstNumberScreenState extends State<FirstNumberScreen> {
  Color selectedColor = Colors.red;
  List<ColoredPoint> brushStrokes = [];
  int strokesSinceLastDialog = 0;
  bool showColors = false;

  @override
  Widget build(BuildContext context) {
    int currentIndex = FirstNumberScreen.numbersData.indexWhere(
      (n) => n["number"] == widget.number,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("الرقم ${widget.number}"),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: currentIndex > 0
              ? () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FirstNumberScreen(
                        number: FirstNumberScreen
                            .numbersData[currentIndex - 1]["number"]!,
                        animal: FirstNumberScreen
                            .numbersData[currentIndex - 1]["animal"]!,
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
            onPressed: currentIndex + 1 < FirstNumberScreen.numbersData.length
                ? () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FirstNumberScreen(
                          number: FirstNumberScreen
                              .numbersData[currentIndex + 1]["letter"]!,
                          animal: FirstNumberScreen
                              .numbersData[currentIndex + 1]["animal"]!,
                        ),
                      ),
                    );
                  }
                : null,
          ),
          IconButton(
            icon: const Icon(Icons.outbox_outlined),
            onPressed: currentIndex + 1 < FirstNumberScreen.numbersData.length
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
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 1000" width="100%" height="100%">
  <text x="50%" y="60%"
        text-anchor="middle"
        dominant-baseline="middle"
        font-size="800"
        font-family="sans-serif"
        fill="none"
        stroke="black"
        stroke-width="4">
    ${widget.number}
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
                        FirstNumberScreen.completedNumbers.add(widget.number);
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
          ArabicNumbersKeyboardWidget(
            onSelect: (letter, animal) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      FirstNumberScreen(number: letter, animal: animal),
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
    if (FirstNumberScreen.completedNumbers.length ==
        FirstNumberScreen.numbersData.length) {
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
              widget.number,
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
              if (currentIndex + 1 < FirstNumberScreen.numbersData.length) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FirstNumberScreen(
                      number: FirstNumberScreen
                          .numbersData[currentIndex + 1]["number"]!,
                      animal: FirstNumberScreen
                          .numbersData[currentIndex + 1]["animal"]!,
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
        canvas.drawCircle(p.offset, 15, paint); // نقاط للتلوين اليدوي
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

  Future<void> _speakNumber(String number) async {
    await _tts.stop();
    await _tts.speak(number);
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
          itemCount: FirstNumberScreen.numbersData.length,
          itemBuilder: (context, index) {
            final number = FirstNumberScreen.numbersData[index]["number"]!;
            final animal = FirstNumberScreen.numbersData[index]["animal"]!;
            final isCompleted = FirstNumberScreen.completedNumbers.contains(
              number,
            );

            return InkWell(
              onTap: isCompleted
                  ? null
                  : () async {
                      await _speakNumber(number);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              FirstNumberScreen(number: number, animal: animal),
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
                  number,
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
