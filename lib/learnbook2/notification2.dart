import 'package:flutter/material.dart';

/// 自定义 Notification
class MyNotification extends Notification {
  final dynamic data;
  MyNotification(this.data);
}

class MyNotification2 extends Notification {
  final dynamic data;
  MyNotification2(this.data);
}

///
/// node
///     node（pa，this）
///          node（node（pa，this），this）
///

class MyNotificationWidget2 extends StatelessWidget {
  const MyNotificationWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}

class Sender extends StatelessWidget {
  const Sender({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      children: [
        ElevatedButton(
          onPressed: () {
            MyNotification('string data...').dispatch(context);
          },
          child: const Text('发送字符串通知'),
        ),
        ElevatedButton(
          onPressed: () {
            MyNotification2(Colors.amber).dispatch(context);
          },
          child: const Text('发送颜色通知'),
        ),
      ],
    );
  }
}
