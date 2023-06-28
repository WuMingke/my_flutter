import 'package:flutter/material.dart';

class MySliverFillViewport extends StatelessWidget {
  const MySliverFillViewport({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            childCount: 5,
            (context, index) => Container(
              color: Colors.primaries[index * 3 % 18],
              child: Center(
                child: Text("item ${index + 1}"),
              ),
            ),
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 16 / 9,
          ),
        ),
        SliverFillViewport(
          viewportFraction: 0.4, // 占屏幕比例
          padEnds: true,
          delegate: SliverChildListDelegate(
            [
              Container(
                color: Colors.grey[200],
                padding: const EdgeInsets.all(48),
                child: const Text("page 1"),
              ),
              Container(
                color: Colors.grey[400],
                padding: const EdgeInsets.all(48),
                child: const Text("page 2"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
