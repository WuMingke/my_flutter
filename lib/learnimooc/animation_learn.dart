import 'package:flutter/material.dart';

/// Flutter中动画可以分为两类：基于tween 、基于物理
///
/// Animation：是Flutter动画库中的一个核心类，它生成指导动画的值；
/// CurvedAnimation：Animation的一个子类，将过程抽象为一个非线性曲线；
/// AnimationController：Animation的一个子类，用来管理Animation；
/// Tween：在正在执行动画的对象所使用的数据范围之间生成值。例如，Tween可生成从红到蓝之间的色值，或者从0到255；
///
/// Animation
/// 在Flutter中，Animation对象本身和UI渲染没有任何关系。Animation是一个抽象类，它拥有其当前值和状态（完成或停止）。
/// 其中一个比较常用的Animation类是Animation<double>。
///
/// Flutter中的Animation对象是一个在一段时间内依次生成一个区间之间值的类。
/// Animation对象的输出可以是线性的、曲线的、一个步进函数或者任何其他可以设计的映射。
/// 根据Animation对象的控制方式，动画可以反向运行，甚至可以在中间切换方向。
///
/// Animation还可以生成除double之外的其他类型值，如：Animation<Color> 或 Animation<Size>；
/// Animation对象有状态。可以通过访问其value属性获取动画的当前值；
/// Animation对象本身和UI渲染没有任何关系；
///
/// CurvedAnimation
///
/// AnimationController
/// AnimationController是一个特殊的Animation对象，在屏幕刷新的每一帧，就会生成一个新的值。
/// 默认情况下，AnimationController在给定的时间段内会线性的生成从0.0到1.0的数字。
///
/// AnimationController派生自Animation<double>，因此可以在需要Animation对象的任何地方使用。
/// 但是，AnimationController具有控制动画的其他方法：
/// forward()：启动动画；
/// reverse({double from})：倒放动画；
/// reset()：重置动画，将其设置到动画的开始位置；
/// stop({ bool canceled = true })：停止动画；
///
/// 当创建一个AnimationController时，需要传递一个vsync参数，
/// 存在vsync时会防止屏幕外动画消耗不必要的资源，可以将stateful对象作为vsync的值。
///
/// Tween
/// Tween是一个无状态(stateless)对象，
/// 继承自Animatable<T>，而不是继承自Animation<T>。Animatable与Animation相似，不是必须输出double值。
/// 要使用Tween对象，可调用它的animate()方法，传入一个控制器对象。
///
/// 监听器：
/// addListener：动画的值发生变化时被调用；
/// addStatusListener：动画状态发生变化时被调用；
///
/// 用AnimatedWidget与AnimatedBuilder简化和重构我们对动画的使用
/// 以将AnimatedWidget理解为Animation的助手,在不使用AnimatedWidget的情况下需要手动调用动画的addListener()并
/// 在回调中添加setState才能看到动画效果，AnimatedWidget将为我们简化这一操作。
///
/// AnimatedBuilder是拆分动画的一个工具类，借助它我们可以将动画和widget进行分离
/// AnimatedBuilder是渲染树中的一个独立的类， 与AnimatedWidget类似，
/// AnimatedBuilder自动监听来自Animation对象的通知，不需要手动调用addListener()。
///
/// Hero动画（过渡动画）
///

class MyAnimation extends StatefulWidget {
  const MyAnimation({Key? key}) : super(key: key);

  @override
  State<MyAnimation> createState() => _MyAnimationState();
}

/// 用 AnimatedWidget 代替 setState 监听
class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo(Key? key, Animation<double> animation) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    Animation<double> animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
}

/// 使用 AnimatedBuilder
class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: const FlutterLogo(),
    );
  }
}

class GrowTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  const GrowTransition(this.child, this.animation, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => SizedBox(
        height: animation.value,
        width: animation.value,
        child: child,
      ),
      child: child,
    );
  }
}

/// 基本实现，在此基础上修改 AnimatedWidget、AnimatedBuilder
class _MyAnimationState extends State<MyAnimation> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  // AnimationStatus? _animationStatus;
  // double _animationValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    _animation = Tween<double>(begin: 0, end: 300).animate(_controller!);
    _controller?.forward();
    // ..addListener(() {
    //   setState(() {
    //     _animationValue = _animation?.value ?? 0;
    //   });
    // })
    // ..addStatusListener((status) {
    //   setState(() {
    //     _animationStatus = status;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    // 第三种
    return GrowTransition(const LogoWidget(), _animation!);
    // 第二种
    // return AnimatedLogo(null, _animation!);
    // 第一种
    // return Column(
    //   children: [
    //     GestureDetector(
    //       onTap: () {
    //         _controller?.reset();
    //         _controller?.forward();
    //       },
    //       child: const Text(
    //         "start",
    //         textDirection: TextDirection.ltr,
    //       ),
    //     ),
    //     Text(
    //       "state:$_animationStatus",
    //       textDirection: TextDirection.ltr,
    //     ),
    //     Text(
    //       "value:$_animationValue",
    //       textDirection: TextDirection.ltr,
    //     ),
    //     SizedBox(
    //       height: _animation?.value,
    //       width: _animation?.value,
    //       child: const FlutterLogo(),
    //     ),
    //   ],
    // );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
