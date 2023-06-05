import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class Animation2 extends StatefulWidget {
  const Animation2({super.key});

  @override
  State<Animation2> createState() => _Animation2State();
}

class _Animation2State extends State<Animation2> with SingleTickerProviderStateMixin {
  final List<Color> colors = [
    const Color(0xFFF60C0C),
    const Color(0xFFF3B913),
    const Color(0xFFE7F716),
    const Color(0xFF3DF30B),
    const Color(0xFF0DF6EF),
    const Color(0xFF0829FB),
    const Color(0xFFB709F4),
  ];
  final List<double> pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];

  Paint _getPaint() {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, _controller.value * 15);
    paint.shader = ui.Gradient.linear(
      Offset.zero,
      const Offset(100, 0),
      colors,
      pos,
      TileMode.mirror,
      Matrix4.rotationZ(pi / 6).storage,
    );
    return paint;
  }

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startAnimation,
      child: Text(
        'mingKE',
        style: TextStyle(fontSize: 60, foreground: _getPaint()),
      ),
    );
  }
}
