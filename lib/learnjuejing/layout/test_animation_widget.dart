import 'dart:math';

import 'package:flutter/material.dart';

class RotatePage extends StatefulWidget {
  const RotatePage({Key? key}) : super(key: key);

  @override
  _RotatePageState createState() => _RotatePageState();
}

class _RotatePageState extends State<RotatePage> with TickerProviderStateMixin {
  AnimationController? _rightController; // 动画 controller
  double? leftViewToLeft; // 小圆点的left（动态计算）
  double? leftViewToTop; // 小远点的right（动态计算）
  double heartWidth = 360;
  double heartHeight = 360 + 200;

  @override
  void initState() {
    super.initState();
    addRightAnimation();
  }

  addRightAnimation() {
    _rightController = AnimationController(duration: const Duration(seconds: 5), vsync: this);
    var x0Right = heartWidth / 2;
    var y0Right = heartHeight / 4;

    var x1Right = (heartWidth * 6) / 7;
    var y1Right = heartHeight / 9;

    var x2Right = (heartWidth * 13) / 13;
    var y2Right = (heartHeight * 2) / 5;

    var x3Right = heartWidth / 2;
    var y3Right = heartHeight * 7 / 12;

    _rightController!.addListener(() {
      // if (_rightController!.isCompleted) {
      //   _rightController!.reverse();
      // }
      // t 动态变化的值
      var t = _rightController!.value;
      if (mounted) {
        setState(() {
          // B3(t) = (1-t)^3*P0+3t(1-t)^2*P1+3t^2(1-t)*P2+t^3*P3,  t属于 [0,1]
          // leftViewToLeft = pow(1 - t, 3) * x0Right + 3 * t * pow(1 - t, 2) * x1Right + 3 * pow(t, 2) * (1 - t) * x2Right + pow(t, 3) * x3Right;
          //
          // leftViewToTop = pow(1 - t, 3) * y0Right + 3 * t * pow(1 - t, 2) * y1Right + 3 * pow(t, 2) * (1 - t) * y2Right + pow(t, 3) * y3Right;
          leftViewToLeft = quadraticBezierTo(t, x0Right, x1Right, x3Right);
          leftViewToTop = quadraticBezierTo(t, y0Right, y1Right, y3Right);
        });
      }
    });

    // B_{2}(t) = (1 - t)^2P_0 + 2t(1 - t)P_1 + t^2P_2

    // 初始化小圆点的位置
    leftViewToLeft = x0Right;
    leftViewToTop = y0Right;

    //显示小圆点的时候动画就开始
    _rightController!.forward();
  }

  double quadraticBezierTo(double t, double start, double control, double end) => pow(1 - t, 2) * start + 2 * t * (1 - t) * control + pow(t, 2) * end;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _childWidget(leftViewToLeft!, leftViewToTop!),
      ],
    );
  }

  Widget _childWidget(double toLeft, double toTop) {
    return Positioned(
      left: toLeft,
      top: toTop,
      child: Stack(children: [
        Image.network(
          "https://img02.sogoucdn.com/app/a/100520093/8379901cc65ba509-45c21ceb904429fc-7f23efc08ddbc10018b13ac470428e84.jpg",
          width: 50,
          height: 50,
        ),
      ]),
    );
  }

  @override
  void dispose() {
    _rightController?.dispose();
    super.dispose();
  }
}
