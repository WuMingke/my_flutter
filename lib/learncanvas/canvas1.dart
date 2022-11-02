import 'dart:math';
import 'dart:ui' as ui show ParagraphConstraints, TextStyle, Image, ParagraphBuilder, ParagraphStyle;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LearnCanvas extends StatelessWidget {
  const LearnCanvas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const Pager();
    // return const Pager2();
    return const Pager3();
  }
}

class Pager3 extends StatefulWidget {
  const Pager3({Key? key}) : super(key: key);

  @override
  State<Pager3> createState() => _Pager3State();
}

class _Pager3State extends State<Pager3> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 20), vsync: this)..forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter4(_controller),
      ),
    );
  }
}

class PaperPainter4 extends CustomPainter {
  final Animation<double> progress;
  // late Paint mPaint;
  // late Path mPath;
  // late Paint mCirclePaint;

  PaperPainter4(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    Paint mPaint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    Path mPath = Path()
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-30, 120)
      ..relativeLineTo(30, -30)
      ..relativeLineTo(30, 30)
      ..close();
    mPath.addOval(Rect.fromCenter(center: Offset.zero, width: 50, height: 50));
    Paint mCirclePaint = Paint()
      ..color = Colors.deepOrange
      ..style = PaintingStyle.fill;
    PathMetrics pms = mPath.computeMetrics();
    for (var element in pms) {
      final tangent = element.getTangentForOffset(element.length * progress.value);
      if (tangent != null) {
        canvas.drawCircle(tangent.position, 5, mCirclePaint);
      }
    }
    canvas.drawPath(mPath, mPaint);
  }

  @override
  bool shouldRepaint(covariant PaperPainter4 oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

class Pager2 extends StatefulWidget {
  const Pager2({Key? key}) : super(key: key);

  @override
  State<Pager2> createState() => _Pager2State();
}

class _Pager2State extends State<Pager2> {
  ui.Image? _image;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter3(_image),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    _image = await _loadImageFromAssets("images/head.jpg");
    setState(() {});
  }

  Future<ui.Image>? _loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    return decodeImageFromList(data.buffer.asUint8List());
  }
}

class PaperPainter3 extends CustomPainter {
  Paint? _paint;
  final strokeWidth = 0.5;
  final color = Colors.blue;
  ui.Image? image;

  PaperPainter3(this.image) {
    _paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    _drawImage(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void _drawImage(Canvas canvas) {
    if (image != null) {
      canvas.drawImage(image!, Offset(-image!.width / 2, -image!.height / 2), _paint!);
    }
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
    // _testTranslate(canvas, size);
    // _drawText(canvas, TextAlign.center);
    // _drawText2(canvas);
    // _drawPath(canvas, size);
    // _drawPath2(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void _drawPath2(Canvas canvas, Size size) {
    // canvas.translate(size.width / 2, size.height / 2);

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

// 绘制左侧
    var rect = Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: 160, height: 100);
    path.lineTo(30, 30);
    path.arcTo(rect, 0, pi * 1.5, false);
    canvas.drawPath(path, paint);

    const offset = Offset(0, 10);
    final newPath = path.shift(offset);
    canvas.drawPath(newPath, paint);

    bool f = newPath.contains(offset);
    print("---------------$f");

    var bound = newPath.getBounds();
    canvas.drawRect(bound, paint);
  }

  void _drawPath(Canvas canvas, Size size) {
    // canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.deepPurpleAccent
      ..style = PaintingStyle.fill;
    path
      ..moveTo(0, 0)
      ..lineTo(60, 80)
      ..lineTo(60, 0)
      ..lineTo(0, -80)
      ..close();
    canvas.drawPath(path, paint);
    // canvas.restore();

    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    path.reset();
    // path
    //   ..moveTo(0, 0)
    //   ..lineTo(-60, 80)
    //   ..lineTo(-60, 0)
    //   ..lineTo(0, -80);
    path.relativeMoveTo(-100, 0);
    path.relativeLineTo(60, 80);
    path.relativeLineTo(0, -80);
    path.relativeLineTo(-60, -80);
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawText2(Canvas canvas) {
    final textPainter = TextPainter(
      text: const TextSpan(
        text: "123",
        style: TextStyle(
          fontSize: 40,
          color: Colors.black,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset.zero);
  }

  void _drawText(Canvas canvas, TextAlign textAlign) {
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: textAlign,
      fontSize: 40,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    ));
    builder.pushStyle(ui.TextStyle(color: Colors.black87, textBaseline: TextBaseline.alphabetic));
    builder.addText("1231");
    final paragraph = builder.build();
    paragraph.layout(const ui.ParagraphConstraints(width: 300));
    canvas.drawParagraph(paragraph, const Offset(0, 0));
    canvas.drawRect(const Rect.fromLTRB(0, 0, 300, 40), Paint()..color = Colors.blue.withAlpha(33));
  }

  void _testTranslate(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 5
      ..color = Colors.lightBlue;
    canvas.translate(size.width / 2, size.height / 2);
    canvas.drawCircle(Offset.zero, 100, paint);
    // canvas.drawShadow(path, color, elevation, transparentOccluder)
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
