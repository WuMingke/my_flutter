import 'dart:math';

import 'package:flutter/material.dart';

class Animation6 extends StatelessWidget {
  const Animation6({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 120,
        height: 120,
        // child: CircleShineImage(imageProvider: AssetImage("images/head.jpg")),
        child: ToggleRotate(child: Image(image: AssetImage("images/head.jpg"))),
      ),
    );
  }
}

class ToggleRotate extends StatefulWidget {
  const ToggleRotate({
    super.key,
    required this.child,
    this.onEnd,
    this.onTap,
    this.beginAngle = 0,
    this.endAngle = 90,
    this.durationMs = 200,
    this.clockwise = true,
    this.curve = Curves.fastOutSlowIn,
  });

  final Widget child;
  final ValueChanged<bool>? onEnd;
  final VoidCallback? onTap;
  final double beginAngle;
  final double endAngle;
  final int durationMs;
  final bool clockwise;
  final Curve curve;

  @override
  State<ToggleRotate> createState() => _ToggleRotateState();
}

class _ToggleRotateState extends State<ToggleRotate> with SingleTickerProviderStateMixin {
  bool _rotated = false;
  late AnimationController _controller;
  late Animation<double> _rotateAnim;

  double get rad => widget.clockwise ? _rotateAnim.value : -_rotateAnim.value;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.durationMs),
    )..repeat(reverse: true);
    _rotateAnim = Tween(
      begin: widget.beginAngle / 180 * pi,
      end: widget.endAngle / 180 * pi,
    ).chain(CurveTween(curve: widget.curve)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleRotate() async {
    widget.onTap?.call();
    if (_rotated) {
      await _controller.reverse();
    } else {
      await _controller.forward();
    }
    _rotated = !_rotated;
    widget.onEnd?.call(_rotated);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _toggleRotate,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Transform(
            transform: Matrix4.rotationZ(rad),
            alignment: Alignment.center,
            child: widget.child,
          );
        },
      ),
    );
  }
}

class CircleShineImage extends StatefulWidget {
  const CircleShineImage({
    super.key,
    this.maxBlurRadius = 30,
    this.color = Colors.purple,
    this.duration = const Duration(seconds: 1),
    this.curve = Curves.ease,
    required this.imageProvider,
    this.radius = 30,
  });

  final double maxBlurRadius;
  final Color color;
  final Duration duration;
  final Curve curve;
  final ImageProvider imageProvider;
  final double radius;

  @override
  State<CircleShineImage> createState() => _CircleShineImageState();
}

class _CircleShineImageState extends State<CircleShineImage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> blurRadiusAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )
      ..addListener(() {
        setState(() {});
      })
      ..repeat(reverse: true);
    blurRadiusAnim = Tween<double>(
      begin: 0,
      end: widget.maxBlurRadius,
    ).chain(CurveTween(curve: widget.curve)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.radius * 2,
      width: widget.radius * 2,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: widget.imageProvider,
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: widget.color,
            blurRadius: blurRadiusAnim.value,
            spreadRadius: 0,
          ),
        ],
      ),
    );
  }
}
