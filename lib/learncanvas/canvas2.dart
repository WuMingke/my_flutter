import 'dart:math';

import 'package:flutter/material.dart';

class LearnCanvas2 extends StatefulWidget {
  const LearnCanvas2({Key? key}) : super(key: key);

  @override
  State<LearnCanvas2> createState() => _LearnCanvas2State();
}

class _LearnCanvas2State extends State<LearnCanvas2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: _buildChildren(),
      ),
    );
  }

  List<Widget> _buildChildren() {
    return List<Widget>.generate(
      6,
      (index) => PicMan(
        color: Colors.lightBlue,
        angle: (1 + index) * 6.0,
      ),
    );
  }
}

class PicMan extends StatefulWidget {
  final Color color;
  final double angle;

  // final Animation<double> angle;
  const PicMan({Key? key, this.color = Colors.lightBlue, required this.angle}) : super(key: key);

  @override
  State<PicMan> createState() => _PicManState();
}

class _PicManState extends State<PicMan> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorCtrl;
  late Animation<double> _angleCtrl;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      // lowerBound: 10,
      // upperBound: 40,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _angleCtrl = _controller.drive(Tween(begin: 10, end: 40));
    _colorCtrl = ColorTween(begin: Colors.blue, end: Colors.red).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 100),
      painter: PicManPainter(color: _colorCtrl, angle: _angleCtrl, repaint: _controller),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class PicManPainter extends CustomPainter {
  final Animation<double> repaint;
  final Animation<double> angle;
  final Animation<Color?> color;

  // final Color color;

  // final double angle;
  final Paint _paint = Paint();

  PicManPainter({required this.repaint, required this.angle, required this.color}) : super(repaint: repaint);

  // PicManPainter({this.color = Colors.yellowAccent, required this.angle}) : super(repaint: angle);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    final radius = size.width / 2;
    canvas.translate(radius, size.height / 2);
    _drawHead(canvas, size);
    _drawEye(canvas, radius);
  }

  @override
  bool shouldRepaint(covariant PicManPainter oldDelegate) {
    return color != oldDelegate.color || angle != oldDelegate.angle;
  }

  void _drawHead(Canvas canvas, Size size) {
    var rect = Rect.fromCenter(center: const Offset(0, 0), height: size.width, width: size.height);
    var a = angle.value / 180 * pi;
    canvas.drawArc(rect, a, 2 * pi - a.abs() * 2, true, _paint..color = color.value!);
  }

  void _drawEye(Canvas canvas, double radius) {
    canvas.drawCircle(Offset(radius * 0.15, -radius * 0.6), radius * 0.12, _paint..color = Colors.white);
  }
}
