import 'package:flutter/material.dart';

class Animation3 extends StatefulWidget {
  const Animation3({super.key});

  @override
  State<Animation3> createState() => _Animation3State();
}

class X2Curve extends Curve {
  // 自定义Curve
  @override
  double transformInternal(double t) {
    return t * t;
  }
}

class _Animation3State extends State<Animation3> with SingleTickerProviderStateMixin {
  // double get radius => 32 + (120 - 32) * _controller.value; // 表达式的话，可以在执行的时候再获得最后的值
  // double radius = 32 + (120 - 32) * _controller.value; //  报错，因为_controller并没有初始化
  // double get radius => 32 + (120 - 32) * curveAnim.value;
  // double get radius => 32 + (120 - 32) * Curves.elasticOut.transform(_controller.value);
  double get radius => 32 + (120 - 32) * X2Curve().transformInternal(_controller.value);

  late AnimationController _controller;

  // late Animation<double> curveAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller.addListener(() {
      setState(() {});
      // print('---- ${curveAnim.value}');
    });
    _controller.addStatusListener((status) {
      print("status:$status");
    });
    // curveAnim = CurvedAnimation(parent: _controller, curve: Curves.elasticOut); // 做数值转换
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
        onTap: () async {
          await _controller.forward();
          print("animation finish");
        },
        child: Container(
          width: radius,
          height: radius,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
