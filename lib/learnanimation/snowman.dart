import 'dart:math';

import 'package:flutter/material.dart';

Widget createSnowman(BuildContext context, AnimationController controller) {
  final List<Snowflake> snowflakes = List.generate(
    10,
    (index) => Snowflake(Random().nextDouble() * 400, Random().nextDouble() * 800),
  );

  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue, Colors.blueAccent, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.0, 0.8, 0.95],
      ),
    ),
    child: AnimatedBuilder(
      animation: controller..repeat(), // 在这里启动
      builder: (_, __) {
        for (var snowflake in snowflakes) {
          snowflake.fall();
        }
        return CustomPaint(
          size: Size.infinite,
          painter: MyPainter(snowflakes),
        );
      },
    ),
  );
}

class MyPainter extends CustomPainter {
  final Paint _paint = Paint()
    ..color = Colors.white
    ..isAntiAlias = true;

  final List<Snowflake> _snowflakes;

  MyPainter(this._snowflakes);

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawRect(Rect.largest, _paint..color = Colors.blue); // 不了解布局，很容易过度绘制
    canvas.drawCircle(size.bottomCenter(const Offset(0, -200)), 40, _paint..color = Colors.white);
    canvas.drawOval(Rect.fromCenter(center: size.bottomCenter(const Offset(0, -50)), width: 200, height: 250), _paint);
    for (var snowflake in _snowflakes) {
      canvas.drawCircle(Offset(snowflake.x, snowflake.y), snowflake.radius, _paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Snowflake {
  double x = 0;
  double y = 0;
  double radius = Random().nextDouble() * 2 + 2;
  double velocity = Random().nextDouble() * 4 + 2;

  Snowflake(this.x, this.y);

  void fall() {
    y += velocity;
    if (y > 800) {
      y = 0;

      x = Random().nextDouble() * 400;
      radius = Random().nextDouble() * 2 + 2;
      velocity = Random().nextDouble() * 4 + 2;
    }
  }
}
