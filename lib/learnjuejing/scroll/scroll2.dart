import 'package:flutter/material.dart';
import 'package:my_flutter/learnjuejing/scroll/scroll1.dart';

class Scroll2 extends StatefulWidget {
  const Scroll2({super.key});

  @override
  State<Scroll2> createState() => _Scroll2State();
}

class _Scroll2State extends State<Scroll2> {
  final List<int> data = List.generate(60, (index) => index + 1);
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            _controller.animateTo(
              60,
              duration: const Duration(seconds: 2),
              curve: Curves.bounceOut,
            );
          },
          child: const SizedBox(
            width: 100,
            height: 50,
            child: ColoredBox(
              color: Colors.greenAccent,
            ),
          ),
        ),
        Expanded(
          child: Scrollable(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollBehavior: NoIndicatorScrollBehavior(), // 贴边后继续滑动无波纹
            axisDirection: AxisDirection.down,
            controller: _controller,
            viewportBuilder: (_, offset) {
              return Viewport(
                // center: const Key('center'),
                cacheExtent: 0, // 默认缓存250逻辑像素
                axisDirection: AxisDirection.down,
                offset: offset,
                slivers: [
                  _buildSliverGrid(),
                  _buildSliverList(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSliverList() {
    return SliverList(
      // key: const Key('center'),
      delegate: SliverChildBuilderDelegate(
        (_, index) {
          return ItemBox(index: index);
        },
        childCount: data.length,
      ),
    );
  }

  Widget _buildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (_, index) {
          return ItemBox(index: index);
        },
        childCount: 9,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
    );
  }
}

class NoIndicatorScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
