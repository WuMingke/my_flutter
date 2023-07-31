import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BottomDragWidget extends StatefulWidget {
  const BottomDragWidget({super.key});

  @override
  State<BottomDragWidget> createState() => _BottomDragWidgetState();
}

class _BottomDragWidgetState extends State<BottomDragWidget> {
  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: DragContainer(),
        )
      ],
    );
  }
}

class DragContainer extends StatefulWidget {
  const DragContainer({super.key});

  @override
  State<DragContainer> createState() => _DragContainerState();
}

class _DragContainerState extends State<DragContainer> with SingleTickerProviderStateMixin {
  double offsetDistance = 0.0;
  late AnimationController _controller;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    final CurvedAnimation curvedAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    // final Animation animation = Tween(begin: )
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, offsetDistance),
      child: RawGestureDetector(
        gestures: {MyVerticalDragGestureRecognizer: getRecognizer()},
        child: Container(
          width: 100,
          height: 100,
          color: Colors.brown,
        ),
      ),
    );
  }

  GestureRecognizerFactoryWithHandlers<MyVerticalDragGestureRecognizer> getRecognizer() {
    return GestureRecognizerFactoryWithHandlers(() => MyVerticalDragGestureRecognizer(null), _initializer);
  }

  void _initializer(MyVerticalDragGestureRecognizer instance) {
    instance
      ..onStart = _onStart
      ..onUpdate = _onUpdate
      ..onEnd = _onEnd;
  }

  ///接受触摸事件
  void _onStart(DragStartDetails details) {
    print('触摸屏幕${details.globalPosition}');
  }

  ///垂直移动
  void _onUpdate(DragUpdateDetails details) {
    print('垂直移动${details.delta}');
    offsetDistance = offsetDistance + details.delta.dy;
    setState(() {});
  }

  ///手指离开屏幕
  void _onEnd(DragEndDetails details) {
    print('离开屏幕');
  }
}

class MyVerticalDragGestureRecognizer extends VerticalDragGestureRecognizer {
  MyVerticalDragGestureRecognizer(Object? debugOwner) : super(debugOwner: debugOwner);
}
