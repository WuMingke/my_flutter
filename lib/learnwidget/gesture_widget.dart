import 'package:flutter/material.dart';

class TestGesture extends StatefulWidget {
  const TestGesture({Key? key}) : super(key: key);

  @override
  State<TestGesture> createState() => _TestGestureState();
}

class _TestGestureState extends State<TestGesture> {
  PointerEvent? _event;

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: Container(
        alignment: Alignment.center,
        color: Colors.blue,
        width: 300,
        height: 150,
        child: Text(
          "${_event?.localPosition ?? ""}",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      onPointerDown: (event) {
        setState(() {
          _event = event;
        });
      },
      onPointerMove: (event) {
        setState(() {
          _event = event;
        });
      },
      onPointerUp: (event) {
        setState(() {
          _event = event;
        });
      },
    );
  }
}

class TestGesture2 extends StatefulWidget {
  const TestGesture2({Key? key}) : super(key: key);

  @override
  State<TestGesture2> createState() => _TestGesture2State();
}

class _TestGesture2State extends State<TestGesture2> {
  String _operation = "No Gesture detected!";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: Text(_operation),
      ),
      onTap: () {
        updateTest("onTap");
      },
      onDoubleTap: () {
        updateTest("onDoubleTap");
      },
    );
  }

  void updateTest(String content) {
    setState(() {
      _operation = content;
    });
  }
}

class Drag extends StatefulWidget {
  const Drag({Key? key}) : super(key: key);

  @override
  State<Drag> createState() => _DragState();
}

class _DragState extends State<Drag> with SingleTickerProviderStateMixin {
  double _top = 0;
  double _left = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: const CircleAvatar(
              child: Text("A"),
            ),
            // onPanDown: (detail) {
            //   print("用户手指按下：${detail.globalPosition}");
            // },
            onHorizontalDragUpdate: (detail) {
              setState(() {
                _top += detail.delta.dy;
                _left += detail.delta.dx;
              });
            },
            // onPanEnd: (detail) {
            //   print(detail.velocity);
            // },
          ),
        ),
      ],
    );
  }
}
