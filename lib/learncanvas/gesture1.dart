import 'package:flutter/material.dart';

class HandleWidget extends StatefulWidget {
  final double size;
  final double handleRadius;

  const HandleWidget({Key? key, this.size = 60, this.handleRadius = 30}) : super(key: key);

  @override
  State<HandleWidget> createState() => _HandleWidgetState();
}

class _HandleWidgetState extends State<HandleWidget> {
  final ValueNotifier<Offset> _offset = ValueNotifier(Offset.zero);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(widget.size, widget.size),
      painter: _HandlePainter(),
    );
  }
}

class _HandlePainter extends CustomPainter {
  final _paint = Paint();
  var handleR;

  _HandlePainter({this.handleR}) {
    _paint
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    final bgR = size.width / 2 - handleR;
    canvas.translate(size.width / 2, size.height / 2);
    _paint.color = _paint.color.withAlpha(100);
    canvas.drawCircle(Offset.zero, bgR, _paint);
    _paint.color = _paint.color.withAlpha(150);
    canvas.drawCircle(Offset.zero, handleR, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
