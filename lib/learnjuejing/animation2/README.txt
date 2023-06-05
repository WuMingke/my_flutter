在 Flutter 动画的使用中，最核心的是 动画器 Animation ，我们可以通过监听 动画器 的数值变化来更新待动画的属性值 。
除此之外还有两个辅助类Curve 、Animatable 用于对 动画器 数值进行转换。

关于 forward 方法还有一个注意点：它的返回值是 TickerFuture 类型，是 Future 的子类，
所以我们可以通过 async/await 或 then 回调 得到动画执行完毕的时机。
          _controller
              .forward()
              .then((value) => {
                    // async/await 或 then 回调 获得动画结束的时机
                    print("animation finish"),
                  });

          onTap: () async {
              await _controller.forward();
              print("animation finish");
          },

Curve:调整动画数值变化规律 --> Android原生插值器

CurvedAnimation 将AnimationController的 lowerBound到upperBound 按照某种转换公式 计算出来
两种写法一致：
Curves.elasticOut.transform(_controller.value)
curveAnim = CurvedAnimation(parent: _controller, curve: Curves.elasticOut)

Tween:计算出 起始对象 和 结束对象 间位于 某分率 的对象 => 补间动画 --> Android原生估值器

public class MyEvaluator implements TypeEvaluator<Integer> {

    @Override
    public Integer evaluate(float fraction, Integer startValue, Integer endValue) {
        int start = startValue;
        int end = endValue;
        int curValue = (int) (start + fraction * (end - start));
        return curValue;
    }
}
Tween是 Animatable的子类， Animatable是抽象类，且可以指定一个泛型 T ，只有一个抽象方法 transform ，它的作用是通过 分率 t 创建 T 类型对象。

CurveTween 继承自 Animatable<double> ，所以可以作为 chain 的入参，这样就能让 Animatable 对象在 transform 时具有曲线效果

TweenSequence 分段动画

这个api什么意思
final result = Path.combine(PathOperation.difference, circlePath, circlePath2);






