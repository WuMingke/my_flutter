import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
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
        body: StampPager(),
      ),
    );
  }
}

class Stamp {
  Color color;
  final Offset center;
  final double radius;
  Stamp({
    this.color = Colors.blue,
    required this.center,
    this.radius = 30,
  });
}

class StampData extends ChangeNotifier {
  final List<Stamp> stamps = [];
  // final Paint _paint = Paint();
  void push(Stamp stamp) {
    stamps.add(stamp);
    notifyListeners(); // 类似Android的自定义绘制的那个刷新方法 inv...
  }

  void removeLast() {
    stamps.removeLast();
    notifyListeners();
  }

  void activeLast() {
    stamps.last.color = Colors.blue;
    notifyListeners();
  }

  void clear() {
    stamps.clear();
    notifyListeners();
  }
}

class StampPainter extends CustomPainter {
  final StampData stampData;
  final Paint _paint = Paint();
  StampPainter({
    required this.stampData,
  }) : super(repaint: stampData);

  @override
  void paint(Canvas canvas, Size size) {
    for (var element in stampData.stamps) {
      canvas.drawCircle(
        element.center,
        element.radius,
        _paint..color = element.color,
      );
    }
  }

  @override
  bool shouldRepaint(covariant StampPainter oldDelegate) {
    return oldDelegate.stampData != stampData;
  }
}

class StampPager extends StatefulWidget {
  const StampPager({super.key});

  @override
  State<StampPager> createState() => _StampPagerState();
}

class _StampPagerState extends State<StampPager> {
  final StampData stampData = StampData();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onDoubleTap: _clear,
      onTapCancel: _removeLast,
      child: CustomPaint(
        painter: StampPainter(stampData: stampData),
        size: MediaQuery.of(context).size,
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    stampData.push(Stamp(center: details.localPosition, color: Colors.grey));
  }

  void _onTapUp(TapUpDetails details) {
    stampData.activeLast();
  }

  void _clear() {
    stampData.clear();
  }

  void _removeLast() {
    stampData.removeLast();
  }

  @override
  void dispose() {
    stampData.dispose();
    super.dispose();
  }
}
