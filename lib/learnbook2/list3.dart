import 'package:flutter/material.dart';

class MyList3 extends StatefulWidget {
  MyList3({super.key});

  @override
  State<MyList3> createState() => _MyList3State();
}

class _MyList3State extends State<MyList3> {
  final list = List.generate(4, (index) => index);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 0,
      // child: _buildListWheelScrollView(),
      child: _buildReorderableListView(),
    );
  }

  Widget _buildReorderableListView() {
    return ReorderableListView(
        children: [
          Text("data${list[0]}", key: const ValueKey(1)),
          Text("data${list[1]}", key: const ValueKey(2)),
          Text("data${list[2]}", key: const ValueKey(3)),
          Text("data${list[3]}", key: const ValueKey(4)),
        ],
        onReorder: (oldIndex, newIndex) {
          print("位于$oldIndex 的元素移动到了 $newIndex");
          setState(() {
            if (newIndex >= list.length) {
              newIndex = list.length - 1;
            }
            final data = list.removeAt(oldIndex);
            list.insert(newIndex, data);
          });
        });
  }

  Widget _buildListWheelScrollView() {
    return ListWheelScrollView(
      physics: const BouncingScrollPhysics(parent: FixedExtentScrollPhysics()),
      // overAndUnderCenterOpacity: 0.5,
      diameterRatio: 0.8,
      itemExtent: 100,
      // useMagnifier: true,
      // magnification: 2,
      // offAxisFraction: 1.1,
      children: [
        for (int i = 0; i < 50; i++) ...{
          Container(
            color: Colors.greenAccent,
          )
        }
      ],
    );
  }
}
