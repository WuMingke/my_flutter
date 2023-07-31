import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const StopwatchApp());
}

/// 计时器
class StopwatchApp extends StatelessWidget {
  const StopwatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StopwatchHomePage(),
    );
  }
}

/// 主页
class StopwatchHomePage extends StatefulWidget {
  const StopwatchHomePage({super.key});

  @override
  State<StopwatchHomePage> createState() => _StopwatchHomePageState();
}

class _StopwatchHomePageState extends State<StopwatchHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          buildActions(),
        ],
      ),
      body: Column(
        children: [
          buildStopwatchPanel(),
          buildRecordPanel(),
          buildTools(),
        ],
      ),
    );
  }

  Widget buildActions() {
    return PopupMenuButton(
      itemBuilder: _buildItem,
      onSelected: _onSelectItem,
      icon: const Icon(
        Icons.more_vert_outlined,
        color: Color(0xff262626),
      ),
      position: PopupMenuPosition.under,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }

  List<PopupMenuEntry<String>> _buildItem(BuildContext context) {
    return [
      const PopupMenuItem(
        child: Center(
          child: Text("设置"),
        ),
      )
    ];
  }

  void _onSelectItem(String value) {}

  Widget buildStopwatchPanel() {
    double radius = MediaQuery.of(context).size.width / 2 * 0.75;
    Duration duration = const Duration(minutes: 3, seconds: 28, milliseconds: 50);
    return const Placeholder();
    // return CustomPaint(
    //   painter: StopwatchPainter(
    //     duration: duration,
    //     radius: radius,
    //     themeColor:,
    //     scaleColor:,
    //     textStyle:,
    //   ),
    //   size: Size(radius * 2, radius * 2),
    // );
  }

  Widget buildRecordPanel() {
    return Expanded(
      child: Container(
        color: Colors.red,
      ),
    );
  }

  Widget buildTools() {
    return Container(
      height: 80,
      color: Colors.yellow,
    );
  }
}

/// 秒表
class StopwatchPainter extends CustomPainter {
  final Duration duration;
  final double radius;
  final Color themeColor;
  final Color scaleColor;
  final TextStyle textStyle;

  StopwatchPainter({
    required this.duration,
    required this.radius,
    required this.themeColor,
    required this.scaleColor,
    required this.textStyle,
  });

  final scalePainter = Paint()
    ..isAntiAlias = true
    ..color = Colors.red
    ..style = PaintingStyle.stroke;

  final double _kScaleWidthRate = 0.4 / 10;
  Offset? offsetStart;
  Offset? offsetEnd;
  Offset? textOffset;

  final textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  TextStyle get commonStyle => TextStyle(
        fontSize: radius / 3,
        fontWeight: FontWeight.w200,
        color: const Color(0xff343434),
      );

  TextSpan? testSpan;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    final double scaleLineWidth = size.width * _kScaleWidthRate;
    offsetStart ??= Offset(size.width / 2, 0);
    offsetEnd ??= Offset(size.width / 2 - scaleLineWidth, 0);
    for (int i = 0; i < 180; i++) {
      canvas.drawLine(offsetStart!, offsetEnd!, scalePainter);
      canvas.rotate(pi / 180 * 2);
    }

    // testSpan ??= TextSpan(
    //     text: "00:04",
    //     style: commonStyle,
    //     children:[TextSpan(text: ".65",style: highlightStyle)]
    // );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
