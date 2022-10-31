import 'package:flutter/material.dart';

class LearnCanvas extends StatelessWidget {
  const LearnCanvas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Pager();
  }
}

class Pager extends StatelessWidget {
  const Pager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        // painter: PaperPainter(),
        painter: PaperPainter2(),
      ),
    );
  }
}

class PaperPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // _testStroke(canvas);
    // _testStroke2(canvas);
    // _testLine(canvas);
    _testTranslate(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void _testTranslate(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 5
      ..color = Colors.lightBlue;
    canvas.translate(size.width / 2, size.height / 2);
    canvas.drawCircle(Offset.zero, 100, paint);
    // TODO: 2022/10/31 mingKE
  }

  void _testLine(Canvas canvas) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.red
      ..strokeWidth = 5;
    final path = Path();
    path.moveTo(50, 50);
    path.lineTo(50, 150);
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.miter);
  }

  void _testStroke2(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;
    canvas.drawLine(const Offset(50, 50), const Offset(50, 150), paint);
  }

  void _testStroke(Canvas canvas) {
    final paint = Paint()..color = Colors.red;
    canvas.drawCircle(
        const Offset(100, 100),
        80,
        paint
          ..strokeWidth = 50
          ..style = PaintingStyle.stroke);

    canvas.drawCircle(
        const Offset(350, 100),
        80,
        paint
          ..strokeWidth = 50
          ..style = PaintingStyle.fill);
  }
}

class PaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint
      ..color = Colors.blue
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    canvas.drawLine(const Offset(0, 0), const Offset(100, 100), paint);

    paint.color = Colors.red;
    final path = Path();
    path.moveTo(100, 100);
    path.lineTo(200, 0);
    canvas.drawPath(path, paint);

    // canvas.drawCircle(const Offset(100, 100), 10, paint);
    _drawIsAntiAliasColor(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void _drawIsAntiAliasColor(Canvas canvas) {
    final paint = Paint();
    canvas.drawCircle(
        const Offset(180, 180),
        100,
        paint
          ..color = Colors.brown
          ..strokeWidth = 5);

    canvas.drawCircle(
        const Offset(180 + 180, 180),
        100,
        paint
          ..color = Colors.blueAccent
          ..isAntiAlias = false
          ..strokeWidth = 5);
  }
}
