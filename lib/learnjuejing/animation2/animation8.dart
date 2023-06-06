import 'package:flutter/material.dart';

class Animation8 extends StatefulWidget {
  const Animation8({super.key});

  @override
  State<Animation8> createState() => _Animation8State();
}

class _Animation8State extends State<Animation8> {
  final double beginOpacity = 1.0;
  final double endOpacity = 0;

  late double _opacity;

  bool get selected => _opacity == 0;

  @override
  void initState() {
    super.initState();
    _opacity = beginOpacity;
  }

  void _onChanged(bool change) {
    setState(() {
      _opacity = change ? endOpacity : beginOpacity;
    });
  }

  void _onEnd() {
    print('------end');
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Switch(
          value: selected,
          onChanged: _onChanged,
        ),
        Container(
          color: Colors.grey.withAlpha(22),
          width: 100,
          height: 100,
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            onEnd: _onEnd,
            child: const Icon(
              Icons.camera_outlined,
              color: Colors.green,
              size: 60,
            ),
          ),
        ),
      ],
    );
  }
}
