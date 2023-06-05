import 'package:flutter/material.dart';

class Animation5 extends StatefulWidget {
  const Animation5({super.key});

  @override
  State<Animation5> createState() => _Animation5State();
}

class Circle {
  final Color? color;
  final double radius;
  final Offset? offset;

  Circle({
    required this.color,
    required this.radius,
    required this.offset,
  });
}

class MyCircleTween extends Tween<Circle> {
  // 自定义Tween 同Android原生估值器
  final Circle startCircle;
  final Circle endCircle;

  MyCircleTween({required this.startCircle, required this.endCircle});

  @override
  Circle lerp(double t) {
    return Circle(
      color: Color.lerp(startCircle.color, endCircle.color, t),
      radius: startCircle.radius + (endCircle.radius - startCircle.radius) * t,
      offset: Offset.lerp(startCircle.offset, endCircle.offset, t),
    );
  }
}

class _Animation5State extends State<Animation5> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // late Circle circle;
  late MyCircleTween myCircleTween;

  Animation<Circle> get _animation => myCircleTween.animate(_controller);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );
    myCircleTween = MyCircleTween(
        startCircle: Circle(offset: Offset.zero, radius: 25, color: Colors.blue),
        endCircle: Circle(offset: const Offset(100, 0), radius: 50, color: Colors.red));
    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        transform: Matrix4.translationValues(
          _animation.value.offset?.dx ?? 0,
          _animation.value.offset?.dy ?? 0,
          0,
        ),
        width: _animation.value.radius * 2,
        height: _animation.value.radius * 2,
        decoration: BoxDecoration(color: _animation.value.color, shape: BoxShape.circle),
      ),
    );
  }
}
