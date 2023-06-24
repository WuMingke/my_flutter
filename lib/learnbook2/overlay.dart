import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyOverlay extends StatefulWidget {
  const MyOverlay({super.key});

  @override
  State<MyOverlay> createState() => _MyOverlayState();
}

class _MyOverlayState extends State<MyOverlay> {
  late OverlayEntry _entry;
  double _left = 50;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () {
                  _entry = OverlayEntry(
                    opaque: false, //  是否渲染下层内容
                    builder: (context) {
                      return Positioned(
                        left: _left,
                        top: 200,
                        child: Container(
                          width: 150,
                          height: 150,
                          // color: Colors.blue,
                          child: const CupertinoPopupSurface(
                            isSurfacePainted: true,
                            child: Material(
                              child: Text('23443'),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                  Overlay.of(context).insert(_entry);
                },
                child: const Text('添加')),
            ElevatedButton(
                onPressed: () {
                  _left += 10;
                  _entry.markNeedsBuild();
                },
                child: const Text('移动')),
            ElevatedButton(
                onPressed: () {
                  _entry.remove();
                },
                child: const Text('删除')),
          ],
        ),
      ),
    );
  }
}
