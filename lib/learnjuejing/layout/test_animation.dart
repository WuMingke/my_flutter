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
        // body: const MyAnimation2(),
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
  late Animation<Offset> animation;
  bool reverse = false;

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
      duration: const Duration(seconds: 2),
      lowerBound: 0.2,
      upperBound: 1.0,
    );

    _locationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          print("-----------");
          setState(() {
            reverse != reverse;
            _locationController.forward();
          });
        }
      });
    animation = Tween(
      begin: const Offset(0.0, 0.0),
      end: const Offset(1.0, 1.0),
    ).animate(_locationController);
  }

  @override
  void dispose() {
    _sizeController.dispose();
    _opacityController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sizeController,
      builder: (BuildContext context, Widget? child) {
        return GestureDetector(
          onTap: () {
            _sizeController.forward();
            _opacityController.forward();
            _locationController.forward();
          },
          child: SlideTransition(
            position: animation,
            child: Opacity(
              opacity: reverse ? 1 - _opacityController.value : _opacityController.value,
              child: SizedBox(
                width: _sizeController.value * 200,
                height: _sizeController.value * 200,
                child: const ColoredBox(color: Colors.red),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BobbleBean {
  // 位置
  Offset position;

  // 运动的速度
  double speed;

  // 运动角度
  double theta;

  // 半径
  double radius;

  BobbleBean(this.position, this.speed, this.theta, this.radius);
}

class MyAnimation2 extends StatefulWidget {
  const MyAnimation2({Key? key}) : super(key: key);

  @override
  State<MyAnimation2> createState() => _MyAnimation2State();
}

class _MyAnimation2State extends State<MyAnimation2> {
  final List<BobbleBean> _list = [];
  final Random _random = Random(DateTime.now().microsecondsSinceEpoch);

  final double _maxTheta = 2 * pi;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 10; i++) {
      final b = BobbleBean(
        const Offset(-1, -1),
        _random.nextDouble() * 0.1,
        _random.nextDouble() * _maxTheta,
        _random.nextDouble() * 100,
      );
      _list.add(b);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Stack(
        children: [
          ..._buildBobble(context),
        ],
      ),
    );
  }

  List<Widget> _buildBobble(BuildContext context) {
    List<Widget> result = [];

    return result;
  }
}
