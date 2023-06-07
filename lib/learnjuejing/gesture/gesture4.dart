import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      home: const Scaffold(
        body: WhitePaper(),
      ),
    );
  }
}

class Point {
  final double x;
  final double y;
  const Point({
    this.x = 0,
    this.y = 0,
  });

  double get distance => sqrt(x * x + y * y);

  factory Point.fromOffset(Offset offset) {
    return Point(
      x: offset.dx,
      y: offset.dy,
    );
  }

  Point operator -(Point other) => Point(x: x - other.x, y: y - other.y);

  Offset toOffset() {
    return Offset(x, y);
  }
}

enum PaintState {
  doing,
  done,
  hide,
}

class Line {
  List<Point> points;
  PaintState state;
  final double strokeWidth;
  final Color color;
  Line({
    this.state = PaintState.doing,
    this.strokeWidth = 1,
    this.color = Colors.black,
  }) : points = [];

  void paint(Canvas canvas, Paint paint) {
    paint
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    canvas.drawPoints(
      PointMode.polygon,
      points.map((e) => e.toOffset()).toList(),
      paint,
    );
  }
}

class PaintModel extends ChangeNotifier {
  final List<Line?> _lines = [];
  List<Line?> get lines => _lines;
  Line? get activeLine => _lines.singleWhere(
        (element) => element?.state == PaintState.doing,
        orElse: () => null,
      );

  void pushLine(Line line) {
    _lines.add(line);
  }

  void pushPoint(Point point, {bool force = false}) {
    if (activeLine == null) return;
    if (activeLine?.points.isNotEmpty == true && !force) {
      if ((point - activeLine!.points.last).distance < 8.0) return;
    }
    activeLine!.points.add(point);
    notifyListeners();
  }

  void doneLine() {
    if (activeLine == null) return;
    activeLine!.state = PaintState.done;
    notifyListeners();
  }

  void clear() {
    for (var element in _lines) {
      element?.points.clear();
    }
    _lines.clear();
    notifyListeners();
  }

  void removeEmpty() {
    _lines.removeWhere((element) => element?.points.isEmpty == true);
  }
}

class PagerPainter extends CustomPainter {
  final PaintModel model;
  PagerPainter({required this.model}) : super(repaint: model);
  final Paint _paint = Paint();
  @override
  void paint(Canvas canvas, Size size) {
    for (var element in model.lines) {
      element?.paint(canvas, _paint);
    }
  }

  @override
  bool shouldRepaint(covariant PagerPainter oldDelegate) {
    return oldDelegate.model != model;
  }
}

class WhitePaper extends StatefulWidget {
  const WhitePaper({super.key});

  @override
  State<WhitePaper> createState() => _WhitePaperState();
}

class _WhitePaperState extends State<WhitePaper> {
  final PaintModel paintModel = PaintModel();
  Color lineColor = Colors.black;
  double strokeWidth = 1;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showSettingDialog,
      onPanDown: _initLineData,
      onPanUpdate: _collectPoint,
      onPanEnd: _doneALine,
      onPanCancel: _cancel,
      // onDoubleTap: _clear,
      child: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: PagerPainter(model: paintModel),
      ),
    );
  }

  @override
  void dispose() {
    paintModel.dispose();
    super.dispose();
  }

  void _cancel() {
    paintModel.removeEmpty();
  }

  void _doneALine(DragEndDetails details) {
    paintModel.doneLine();
  }

  void _collectPoint(DragUpdateDetails details) {
    paintModel.pushPoint(Point.fromOffset(details.localPosition));
  }

  void _initLineData(DragDownDetails details) {
    final Line line = Line(color: lineColor, strokeWidth: strokeWidth);
    paintModel.pushLine(line);
  }

  void _showSettingDialog() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => PaintSettingDialog(
              initColor: lineColor,
              initWidth: strokeWidth,
              onLineWidthSelect: _selectWidth,
              onColorSelect: _selectColor,
            ));
  }

  void _selectWidth(double width) {
    strokeWidth = width;
  }

  void _selectColor(Color color) {
    lineColor = color;
  }
}

typedef LineWidthCallback = void Function(double width);

class LineWidthSelect extends StatefulWidget {
  const LineWidthSelect({
    super.key,
    required this.numbers,
    this.width = 25,
    this.onLineWidthSelect,
    this.defaultWidth = 1.0,
  });
  final List<double> numbers;
  final double width;
  final LineWidthCallback? onLineWidthSelect;
  final double defaultWidth;

  @override
  State<LineWidthSelect> createState() => _LineWidthSelectState();
}

class _LineWidthSelectState extends State<LineWidthSelect> {
  int _selectIndex = 0;
  double get activeWidth => widget.numbers[_selectIndex];
  @override
  void initState() {
    super.initState();
    _selectIndex = widget.numbers.indexOf(widget.defaultWidth);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 45,
      child: Wrap(
        spacing: 20,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: widget.numbers
            .map((e) => GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    _doSelectWidth(e);
                  },
                  child: _buildItem(e),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildItem(double width) {
    return Container(
      alignment: Alignment.center,
      height: widget.width,
      width: widget.width,
      padding: const EdgeInsets.all(5),
      decoration: activeWidth == width
          ? BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(5),
            )
          : null,
      child: Container(
        height: width,
        color: Colors.black,
      ),
    );
  }

  void _doSelectWidth(double width) {
    int index = widget.numbers.indexOf(width);
    if (index == _selectIndex) return;
    setState(() {
      _selectIndex = index;
    });
    widget.onLineWidthSelect?.call(width);
  }
}

typedef ColorSelectCallback = void Function(Color color);

class ColorSelect extends StatefulWidget {
  const ColorSelect({
    super.key,
    required this.colors,
    this.radius = 25,
    this.onColorSelect,
    this.defaultColor = Colors.black,
  });
  final List<Color> colors;
  final double radius;
  final ColorSelectCallback? onColorSelect;
  final Color defaultColor;

  @override
  State<ColorSelect> createState() => _ColorSelectState();
}

class _ColorSelectState extends State<ColorSelect> {
  int _selectIndex = 0;
  Color get activeColor => widget.colors[_selectIndex];
  @override
  void initState() {
    super.initState();
    _selectIndex = widget.colors.indexOf(widget.defaultColor);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 45,
      child: Wrap(
        spacing: 20,
        children: widget.colors
            .map((e) => GestureDetector(
                  onTap: () => _doSelectColor(e),
                  child: _buildItem(e),
                ))
            .toList(),
      ),
    );
  }

  // 构建圆圈
  Widget _buildItem(Color color) => Container(
      width: widget.radius,
      height: widget.radius,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: activeColor == color ? _buildActiveIndicator() : null);
  // 构建白圆圈指示器
  Widget _buildActiveIndicator() => Container(
      width: widget.radius * 0.6,
      height: widget.radius * 0.6,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ));
  // 执行选中方法，触发回调
  void _doSelectColor(Color e) {
    int index = widget.colors.indexOf(e);
    if (index == _selectIndex) return;
    setState(() {
      _selectIndex = index;
    });
    widget.onColorSelect?.call(e);
  }
}

const List<Color> _kColorSupport = [
  Colors.black,
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.indigo,
  Colors.purple,
];

const List<double> _kWidthSupport = [
  1.0,
  3.0,
  5.0,
  6.0,
  8.0,
  9.0,
  12.0,
  15.0,
];

class PaintSettingDialog extends StatelessWidget {
  const PaintSettingDialog({
    super.key,
    this.onLineWidthSelect,
    this.onColorSelect,
    this.initColor = Colors.black,
    this.initWidth = 1.0,
  });

  final LineWidthCallback? onLineWidthSelect;
  final ColorSelectCallback? onColorSelect;
  final Color initColor;
  final double initWidth;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildColorSelect(),
            const Divider(
              height: 1,
            ),
            _buildLineWidthSelect(),
            Container(
              color: const Color(0xffe5e3e4).withOpacity(0.3),
            ),
            _buildCancel(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCancel(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Ink(
        width: MediaQuery.of(context).size.width,
        height: 50,
        color: Colors.white,
        child: const Center(
          child: Text(
            '取消',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildColorSelect() {
    return ColorSelect(
      colors: _kColorSupport,
      onColorSelect: onColorSelect,
    );
  }

  Widget _buildLineWidthSelect() {
    return LineWidthSelect(
      numbers: _kWidthSupport,
      onLineWidthSelect: onLineWidthSelect,
    );
  }
}
