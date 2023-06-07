import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Gesture5 extends StatefulWidget {
  const Gesture5({super.key});

  @override
  State<Gesture5> createState() => _Gesture5State();
}

class _Gesture5State extends State<Gesture5> {
  String action = '';
  Color color = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        TapGestureRecognizer: GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
          () => TapGestureRecognizer(),
          (instance) {
            instance
              ..onTapDown = _tapDown
              ..onTapUp = _tapUp
              ..onTap = _tap
              ..onTapCancel = _tapCancel;
          },
        ),
      },
      child: Container(
        width: 100.0,
        height: 100.0,
        color: color,
        alignment: Alignment.center,
        child: Text(
          "action:$action",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    setState(() {
      action = 'down';
      color = Colors.blue;
    });
  }

  void _tapUp(TapUpDetails details) {
    setState(() {
      action = 'up';
      color = Colors.purple;
    });
  }

  void _tap() {
    setState(() {
      action = 'tap';
    });
  }

  void _tapCancel() {
    setState(() {
      action = 'cancel';
      color = Colors.orange;
    });
  }
}
