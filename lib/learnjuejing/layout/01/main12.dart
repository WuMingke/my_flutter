import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Stack(
        children: [
          Positioned(
              top: 200,
              left: 200,
              child: Builder(builder: (context) {
                return GestureDetector(
                  onTap: () {
                    RenderObject? r = context.findRenderObject();
                    if (r != null && r is RenderBox) {
                      Size size = r.size;
                      Offset offset = r.localToGlobal(Offset.zero);
                      print('---size:$size,offset:$offset');
                    }
                  },
                  child: const SizedBox(
                    width: 100,
                    height: 100,
                    child: ColoredBox(color: Colors.green),
                  ),
                );
              }))
        ],
      ),
    ),
  );
}
