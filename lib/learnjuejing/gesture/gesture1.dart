import 'package:flutter/material.dart';

class Gesture1 extends StatefulWidget {
  const Gesture1({super.key});

  @override
  State<Gesture1> createState() => _Gesture1State();
}

class _Gesture1State extends State<Gesture1> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        ///单击👇
        onTapDown: (details) {
          print("onTapDown ${details.kind} ${details.localPosition} ${details.globalPosition}");
        },
        onTapUp: (details) {
          print("onTapUp ${details.kind} ${details.localPosition} ${details.globalPosition}");
        },
        onTap: () {
          print("onTap");
        },
        onTapCancel: () {
          print("onTapCancel");
        },

        ///双击👇
        onDoubleTapDown: (details) {
          print("onDoubleTapDown ${details.kind} ${details.localPosition} ${details.globalPosition}");
        },
        onDoubleTap: () {
          print("onDoubleTap");
        },
        onDoubleTapCancel: () {
          print("onDoubleTapCancel");
        },

        /// 长按👇
        onLongPress: () {
          print("onLongPress");
        },
        onLongPressStart: (details) {
          print("onLongPressStart ${details.localPosition} ${details.globalPosition}");
        },
        onLongPressUp: () {
          print("onLongPressUp");
        },
        onLongPressEnd: (details) {
          print("onLongPressEnd ${details.localPosition} ${details.globalPosition}");
        },
        onLongPressMoveUpdate: (details) {
          print("onLongPressMoveUpdate ${details.localPosition} ${details.globalPosition}");
        },
        onLongPressCancel: () {
          // 还没有产生onLongPressMoveUpdate时
          print("onLongPressCancel");
        },

        // /// 平移👇
        // onPanDown: (details) {
        //   print("平移 onPanDown");
        // },
        // onPanStart: (details) {
        //   print("平移 onPanStart");
        // },
        // onPanUpdate: (details) {
        //   print("平移 onPanUpdate");
        // },
        // onPanCancel: () {
        //   // 当触发了 onPanDown 但未完成时触发，现象上来说就是没有触发onPanUpdate，快速滑动的时候
        //   print("平移 onPanCancel");
        // },
        // onPanEnd: (details) {
        //   print("平移 onPanEnd");
        // },

        // /// 水平拖拽👇
        // onHorizontalDragDown: (details) {},
        // onHorizontalDragStart: (details) {},
        // onHorizontalDragUpdate: (details) {},
        // onHorizontalDragCancel: () {},
        // onHorizontalDragEnd: (details) {},
        //                                      不能同时使用 可以看作是 Pan 事件在水平和竖直方向的使用
        // /// 垂直拖拽👇
        // onVerticalDragDown: (details) {},
        // onVerticalDragStart: (details) {},
        // onVerticalDragUpdate: (details) {},
        // onVerticalDragCancel: () {},
        // onVerticalDragEnd: (details) {},
        //
        /// 缩放👇  不能与pan同时使用
        onScaleStart: (details) {
          print("缩放 onScaleStart");
        },
        onScaleUpdate: (details) {
          print("缩放 onScaleUpdate");
        },
        onScaleEnd: (details) {
          print("缩放 onScaleEnd");
        },
        child: const SizedBox(
          width: 120,
          height: 120,
          child: ColoredBox(color: Colors.blue),
        ),
      ),
    );
  }
}
