import 'package:arabic_letters_game/ThirdLetterScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SecondLetterScreen extends StatefulWidget {
  @override
  _SecondLetterScreenState createState() => _SecondLetterScreenState();
}

class _SecondLetterScreenState extends State<SecondLetterScreen> {
  Color selectedColor = Colors.red;
  List<ColoredPoint> brushStrokes = [];
  int strokesSinceLastDialog = 0;

  @override
  Widget build(BuildContext context) {
    final double letterSize = MediaQuery.of(context).size.width * 0.9;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("الحرف الثاني"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: SvgPicture.string(
                    '''
<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" viewBox="0 0 1000 1000">
  <text x="50%" y="70%" text-anchor="middle" dominant-baseline="central"
        font-family="Amiri" font-size="1000"
        fill="none" stroke="black" stroke-width="10">
    ب
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
                        Future.delayed(Duration(milliseconds: 300), () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text("أحسنت 🎉"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text("🍊", style: TextStyle(fontSize: 120)),
                                  SizedBox(height: 20),
                                  Text(
                                    "بـرْتقال",
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => ThirdLetterScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text("إلى الحرف التالي ➡️"),
                                ),
                              ],
                            ),
                          );
                        });
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

          // لوحة الألوان
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey.shade200,
            height: 80,
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
                  _colorButton(const Color(0xFF00FF7F)),
                  _colorButton(Colors.lime),
                  _colorButton(Colors.indigo),
                  _colorButton(Colors.deepOrange),
                  const SizedBox(width: 20),
                  Icon(Icons.brush, size: 40, color: selectedColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _colorButton(Color color) {
    return GestureDetector(
      onTap: () => setState(() => selectedColor = color),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: 50,
        height: 50,
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

// كائن يمثل نقطة ملونة
class ColoredPoint {
  final Offset offset;
  final Color color;
  ColoredPoint(this.offset, this.color);
}

// الرسام: يرسم النقاط مع ألوانها
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
