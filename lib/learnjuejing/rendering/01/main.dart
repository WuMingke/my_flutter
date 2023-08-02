import 'package:flutter/material.dart';

void main() {
  runApp(const ColoredBox(color: Colors.red));
}

/// 虽然是异步，但多个 Timer.run 开启的任务也会按照任务队列依次执行
// void main() {
//   print("============1");
//   Timer.run(() {
//     print("============2");
//   });
//   Future(() {
//     print("============4");
//   });
//   Timer.run(() {
//     print("============5");
//   });
//   print("============3");
// }
