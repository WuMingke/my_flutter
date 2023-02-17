import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        // body: RotatePage(),
        body: const MyAnimation(),
      ),
    );
  }
}

class MyAnimation extends StatefulWidget {
  const MyAnimation({Key? key}) : super(key: key);

  @override
  State<MyAnimation> createState() => _MyAnimationState();
}

class _MyAnimationState extends State<MyAnimation> with TickerProviderStateMixin {
  late AnimationController _sizeController;
  late AnimationController _opacityController;
  late AnimationController _locationController;
  bool reverse = false;
  double x = 0;
  double y = 0;

  @override
  void initState() {
    super.initState();
    _sizeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
      lowerBound: 0.2,
      upperBound: 1.0,
    );

    _opacityController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
      lowerBound: 0.0,
      upperBound: 1.0,
    );

    _locationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _opacityController.reset();
          _opacityController.forward();
          _sizeController.reset();
          _sizeController.forward();
          _locationController.reset();
          _locationController.forward();
        }
      })
      ..addListener(() {
        if (mounted) {
          final t = _locationController.value;
          setState(() {
            x = quadraticBezierTo(t, _width / 2, _control.dx, halfSpace());
            y = quadraticBezierTo(t, _width / 2, _control.dy, halfSpace());
          });
        }
      });
  }

  final _control = const Offset(50, 150);

  @override
  void dispose() {
    _sizeController.dispose();
    _opacityController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  final double _itemWidth = 10;
  double _width = 0;

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: _sizeController,
      builder: (BuildContext context, Widget? child) {
        return GestureDetector(
          onTap: () {
            _sizeController.forward();
            _opacityController.forward();
            _locationController.forward();
          },
          child: Container(
            color: Colors.green,
            width: _width,
            height: _width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                /* 以下是定位 */
                /***
                 *   1    2
                 * 3   0    4
                 *   5    6
                 *
                 */

                Positioned(
                  //0
                  child: buildSizedBox(),
                ),
                Positioned(
                  //1
                  top: halfSpace(),
                  left: halfSpace(),
                  child: buildSizedBox(),
                ),
                Positioned(
                  //2
                  top: halfSpace(),
                  right: halfSpace(),
                  child: buildSizedBox(),
                ),
                Positioned(
                  //3
                  top: space(),
                  left: 10,
                  child: buildSizedBox(),
                ),
                Positioned(
                  //4
                  top: space(),
                  right: 10,
                  child: buildSizedBox(),
                ),
                Positioned(
                  //5
                  bottom: halfSpace(),
                  left: halfSpace(),
                  child: buildSizedBox(),
                ),
                Positioned(
                  //5
                  bottom: halfSpace(),
                  right: halfSpace(),
                  child: buildSizedBox(),
                ),

                // 控制点
                Positioned(
                  left: _control.dx,
                  top: _control.dy,
                  child: SizedBox(
                    height: _itemWidth,
                    width: _itemWidth,
                    child: const ColoredBox(color: Colors.yellow),
                  ),
                ),
                // 路径
                CustomPaint(
                  painter: PathPainter(_width / 2, _control.dx, _control.dy, halfSpace()),
                  size: Size(_width, _width),
                ),

                /* 动画 */
                Positioned(
                  // top: _locationController.value * 50,
                  // left: _locationController.value * 50,
                  top: y,
                  left: x,
                  child: Opacity(
                    opacity: reverse ? 1 - _opacityController.value : _opacityController.value,
                    child: SizedBox(
                      width: _sizeController.value * 4 * _itemWidth,
                      height: _sizeController.value * 4 * _itemWidth,
                      child: const ColoredBox(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  SizedBox buildSizedBox() {
    return SizedBox(
      width: _itemWidth,
      height: _itemWidth,
      child: const ColoredBox(color: Colors.red),
    );
  }

  double space() => _width / 2 - _itemWidth / 2;
  double halfSpace() => (space() - _itemWidth) / 2;

  // 二阶贝塞尔曲线
  double quadraticBezierTo(double t, double start, double control, double end) {
    return pow(1 - t, 2) * start + 2 * t * (1 - t) * control + pow(t, 2) * end;
  }

  double x0() {
    return (_width / 2 + space() / 2) / 2;
  }
}

class PathPainter extends CustomPainter {
  final double start;
  final double cx;
  final double cy;
  final double end;

  final Paint mPaint = Paint()
    ..isAntiAlias = true
    ..strokeWidth = 3
    ..style = PaintingStyle.stroke
    ..color = Colors.black26;

  final Path path = Path();

  PathPainter(this.start, this.cx, this.cy, this.end);

  @override
  void paint(Canvas canvas, Size size) {
    path.moveTo(start, start);
    path.quadraticBezierTo(cx, cy, end, end);
    canvas.drawPath(path, mPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
