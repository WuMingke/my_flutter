动画控件分类
   在像素级别绘制  CustomPainter  （最底层）
   框架          Rive/Flare/Lottie

   不用控制的    (全自动)隐式动画： AnimatedXXX
                自定义隐式动画： TweenAnimationBuilder
   需要控制的     (手动控制)显式动画 需要用到动画控制器、还需要回收它： XXXTransition
                自定义显式动画： AnimatedBuilder

隐式动画：
1 AnimatedContainer
2 AnimatedSwitcher 不同控件之间的转换；同控件内容改变->key
3 AnimatedOpacity
  AnimatedPadding   curve 类似插值器的作用
  https://api.flutter.dev/flutter/animation/Curves-class.html
4 不知道api，自定义 TweenAnimationBuilder
    其实就是内部控件利用builder反复执行时的value参数
    builder 方法里封装了"估值器"
    最后，begin，end是个T，任意类型都可以，比如平移（Transform.translate）的时候传Offset

显式动画：
1 RotationTransition  -> AnimationController
                            SingleTickerProviderStateMixin
                            Ticker 滴答滴答，每次屏幕要刷新的时候，就会产生一个Ticker，60帧的屏幕就会"跳动"60下，就会回调到用的地方，
                            AnimationController 的vsync就可以得到数据
                                在duration内根据不同的帧数，计算，类似于tween
                                lowerBound 下限
                                upperBound 上限
                                相当于 借助垂直同步，在上限和下限之间，在duration内，计算出变化，保存在value内，做出动画
                                那么在例子里，传给turns的，就是[下限..上限]的一系列的数字
 FadeTransition

2 快捷键 stanim

3 映射Tween 控制进度  _controller.drive(Tween(begin: 0.5, end: 1.0)),
        或者 Tween(begin: 0.5, end: 1.0).chain(CurveTween(curve: Curves.fastOutSlowIn)).animate(_controller)
        效果是一样的，还可以叠加
4 自定义 AnimatedBuilder
    对比 TweenAnimationBuilder 的value，AnimatedBuilder就是用 _controller的 value
    或者使用：Tween(begin: 50.0, end: 200.0).evaluate(_controller),
    /// 三种写法都可以

    两个builder里面的widget参数：优化作用，减少不必要的widget重建。把不需要重建的widget放到外面，builder里面传的这个widget就是外面的那个widget

原理：
    隐式动画：implicit_animations.dart   ImplicitlyAnimatedWidget
    显式动画：transitions.dart   AnimatedWidget
        A number of implicitly animated widgets ship with the framework.
    AnimatedXXX -> 创建 AnimatedWidgetBaseState -> 监听 addListener -> 调用 setState(() { });
    XXXTransition -> AnimatedWidget -> 监听 listenable.addListener -> 调用 setState(() { });
    特别的：FadeTransition 没找到流程，但是最后还是调用了 setState(() { });




其它：
    Hero：转场动画，
    CustomPainter：自定义绘制结合动画api实现自定义动画
    Rive/Flare/Lottie：第三方素材动画


