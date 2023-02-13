import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Container(
          color: Colors.redAccent,
          child: SizedBox(
            width: 100,
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white30,
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.refresh),
                    Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Text(
                        '换一批',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 自定义RenderObject
class MyRenderBox extends SingleChildRenderObjectWidget {
  const MyRenderBox(Widget child, {super.key}) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderMyRenderBox();
  }
}

///                       extends RenderBox with RenderObjectWithChildMixin
class RenderMyRenderBox extends RenderProxyBox {
  @override
  void performLayout() {
    child?.layout(constraints);
    size = const Size(300, 300);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    /// layout 和 paint 是两个几乎无关的操作，所以绘制的时候可以在任意位置画
    if (child == null) return;
    context.paintChild(child!, offset);

    // paintOverflowIndicator(); 绘制边界警戒线的，有些组件有，有些组件没有，它不是系统的，
  }
}
