import 'package:flutter/material.dart';

class CurveBox extends StatefulWidget {
  final Color color;
  final Curve curve;

  const CurveBox({Key? key, required this.color, required this.curve}) : super(key: key);

  @override
  State<CurveBox> createState() => _CurveBoxState();
}

class _CurveBoxState extends State<CurveBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _angleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    _angleAnimation = CurveTween(curve: widget.curve).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const CustomPaint(
      size: Size(100, 100),
    );
  }
}
