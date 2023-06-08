import 'package:flutter/material.dart';

class Scroll3 extends StatelessWidget {
  Scroll3({super.key});

  final List<int> data = List.generate(60, (index) => index + 1);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildBox(),
        _buildHeader(),
        _buildSpace(),
        _buildSliverGrid(),
        _buildSliverList(),
      ],
    );
  }

  Widget _buildHeader() {
    return SliverPersistentHeader(
      delegate: Head2(min: 50, max: 150),
      floating: true,
      pinned: true,
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

class Head2 extends SliverPersistentHeaderDelegate {
  final double max;
  final double min;
  Head2({required this.max, required this.min});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      alignment: Alignment.center,
      color: Colors.red,
      child: const Text(
        'xi ding',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  double get maxExtent => max;

  @override
  double get minExtent => min;

  @override
  bool shouldRebuild(covariant Head2 oldDelegate) {
    return oldDelegate.max != max || oldDelegate.min != min;
  }
}

class Head extends SliverPersistentHeaderDelegate {
  final double height;
  Head({required this.height});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: height,
      alignment: Alignment.center,
      color: Colors.red,
      child: const Text(
        'xi ding',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant Head oldDelegate) {
    return oldDelegate.height != height;
  }
}
