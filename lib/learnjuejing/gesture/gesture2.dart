import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Gesture2 extends StatefulWidget {
  const Gesture2({super.key});

  @override
  State<Gesture2> createState() => _Gesture2State();
}

class _Gesture2State extends State<Gesture2> {
  @override
  Widget build(BuildContext context) {
    return const SpringWidget();
  }
}

class SpringWidget extends StatefulWidget {
  const SpringWidget({super.key});

  @override
  State<SpringWidget> createState() => _SpringWidgetState();
}

class _SpringWidgetState extends State<SpringWidget> with SingleTickerProviderStateMixin {
  final ValueNotifier<double> height = ValueNotifier(100); // 弹簧高度
  double _s = 0; // 移动距离
  late AnimationController _controller;
  double _laseMoveLen = 0;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addListener(_updateHeightByAnim);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
  }

  void _updateHeight(DragUpdateDetails details) {
    _s += details.delta.dy;
    height.value = 100 - _s / 1.5; // 默认高度+形变量
  }

  void _animateToDefault(DragEndDetails details) {
    _laseMoveLen = _s;
    _controller.forward(from: 0);
  }

  void _updateHeightByAnim() {
    _s = _laseMoveLen * (1 - _animation.value);
    height.value = 100 - _s / 1.5;
  }

  @override
  void dispose() {
    _controller.dispose();
    height.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      color: Colors.grey.withAlpha(11),
      child: GestureDetector(
        onVerticalDragUpdate: _updateHeight,
        onVerticalDragEnd: _animateToDefault,
        child: CustomPaint(
          painter: SpringPainter(
            height: height,
          ),
        ),
      ),
    );
  }
}

class SpringPainter extends CustomPainter {
  final int count;
  final ValueListenable<double> height;
  SpringPainter({this.count = 20, required this.height}) : super(repaint: height);

  /// height改变触发重绘
  final Paint _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;
  final double _kSpringWidth = 30;
  final Path _path = Path();
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height);
    _path.reset();
    _path.relativeLineTo(_kSpringWidth, 0);
    final double space = height.value / (count - 1);
    for (int i = 1; i < count; i++) {
      if (i % 2 == 1) {
        _path.relativeLineTo(-_kSpringWidth, -space);
      } else {
        _path.relativeLineTo(_kSpringWidth, -space);
      }
    }
    _path.relativeLineTo(count.isOdd ? -_kSpringWidth : _kSpringWidth, 0);
    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(covariant SpringPainter oldDelegate) {
    return oldDelegate.count != count || oldDelegate.height != height;
  }
}
