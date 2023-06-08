import 'package:flutter/material.dart';

class Scroll1 extends StatelessWidget {
  Scroll1({super.key});

  final List<int> data = List.generate(60, (index) => index + 1);
  final List<Widget> children = List.generate(60, (index) {
    return index + 1;
  }).map((e) {
    return ItemBox(index: e);
  }).toList();

  @override
  Widget build(BuildContext context) {
    // return ListView(
    //   itemExtent: 56,
    //   children: children,
    // );

    // return ListView.builder(
    //   itemCount: data.length,
    //   cacheExtent: 0, // 高度
    //   itemBuilder: (_, index) {
    //     print('创建 $index');
    //     return ItemBox(
    //       index: index,
    //     );
    //   },
    // );

    // return GridView(
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 3,
    //     childAspectRatio: 1,
    //     crossAxisSpacing: 8,
    //     mainAxisSpacing: 8,
    //     // mainAxisExtent:,
    //   ),
    //   children: children,
    // );

    // return CustomScrollView(
    //   slivers: [
    //     _buildBox(),
    //     _buildSpace(),
    //     _buildSliverGrid(), // 这里就可以展示多类型了
    //     _buildSliverList(),
    //   ],
    // );

    return Scrollable(
      axisDirection: AxisDirection.down,
      controller: null,
      viewportBuilder: (_, offset) {
        return Viewport(
          axisDirection: AxisDirection.down,
          offset: offset,
          slivers: [
            _buildSliverGrid(),
            _buildSliverList(),
          ],
        );
      },
    );
  }

  Widget _buildSpace() {
    return const SliverPadding(
      padding: EdgeInsets.only(top: 100),
    );
  }

  Widget _buildBox() {
    return SliverToBoxAdapter(
      child: Container(
        height: 60,
        color: Colors.amber,
      ),
    );
  }

  Widget _buildSliverList() {
    return SliverList(
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

class ItemBox extends StatelessWidget {
  const ItemBox({super.key, required this.index});

  final int index;

  Color get color => Colors.blue.withOpacity((index % 10) * 0.1);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: color,
      height: 56,
      child: Text(
        '第 $index 个',
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
