import 'package:flutter/material.dart';

class Animation4 extends StatefulWidget {
  const Animation4({super.key});

  @override
  State<Animation4> createState() => _Animation4State();
}

class _Animation4State extends State<Animation4> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Color? get color => Color.lerp(Colors.blue, Colors.red, _controller.value);
  // Color? get color => ColorTween(begin: Colors.blue, end: Colors.red).transform(_controller.value);
  // Color? get color => ColorTween(begin: Colors.blue, end: Colors.red).animate(_controller).value;
  Color? get color => ColorTween(begin: Colors.blue, end: Colors.red)
      .chain(
        CurveTween(curve: Curves.bounceOut),
      )
      .animate(_controller)
      .value;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          _controller.forward();
        },
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
